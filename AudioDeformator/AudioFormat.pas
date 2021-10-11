unit AudioFormat;

interface

uses
  SysUtils, FileUtils;

type
  TAudioFile = class(TFile)
  end;

type
  TAudioData = class(TObject)
  public
    nChannels: Word;
    nSamplesPerSec: LongWord;
    nBitsPerSample: Word;
    nBlockAlign: Word;
    Data: TFile;
    constructor Create;
    destructor Destroy;
    procedure Calculate_nBlockAlign;
    procedure ReadSample(Number, Channel: LongInt; var Value: Integer);
    procedure WriteSample(Number, Channel: LongInt; Value: Integer);
    function Extremum(Number, Channel: LongInt): Boolean;
  private
    Name: String;
  end;

procedure CopyAudio(var AudioSource, AudioGeter: TAudioData; Start, Finish: Cardinal);
procedure DeleteAudio(var AudioData: TAudioData; Start, Finish: Cardinal);
procedure InsertAudio(var AudioSource, AudioGeter: TAudioData; Start: Cardinal);
procedure OverwriteAudio(var AudioSource, AudioGeter: TAudioData; Start: Cardinal);
procedure MixAudio(var AudioSource, AudioGeter: TAudioData; Start: Cardinal);
procedure ReverseAudio(var AudioData: TAudioData; Start, Count: Cardinal);
procedure AddBrainWave(var AudioData: TAudioData; Start, Count, Freq1, Freq2: Integer);
procedure SetSpeedOfAudio(var AudioData: TAudioData; Start, Count: Cardinal; Speed: Real);
function ChangeSpeedOfAudio(var AudioData: TAudioData; Start, Count: Cardinal; Speed: Real): Cardinal;
procedure SetnSamplesPerSec(var AudioData: TAudioData; Value: Cardinal);
procedure SetnBitsPerSample(var AudioData: TAudioData; Value: Cardinal);
procedure SetnChannels(var AudioData: TAudioData; Value: Cardinal);
procedure SetVolumeOfAudio(var AudioData: TAudioData; Start, Count: Cardinal; Volume: Real);
procedure Echo(var AudioData: TAudioData; Start, Count, Number, Delay: Cardinal; Volume: Real);
procedure Reverberation(var AudioData: TAudioData; Start, Count, Number, Delay: Cardinal; Volume: Real);
procedure ChangeVolumeOfAudio(var AudioData: TAudioData; Start, Count: Cardinal; Volume: Real);
procedure ReChangeVolumeOfAudio(var AudioData: TAudioData; Start, Count: Cardinal; Volume: Real);
procedure Normalize(var AudioData: TAudioData; Start, Count: Cardinal);

implementation

constructor TAudioData.Create;
var
  TempDir, FileName: String;
  i: Word;
begin
  inherited Create;
  TempDir := GetEnvironmentVariable('TEMP')+'\';
  i := 0;
  FileName := TempDir + '\' + '0.TAD';
  while FileExists(FileName) do
  begin
    Inc(i);
    Str(i, FileName);
    FileName := TempDir + '\' + FileName + '.TAD';
  end;
  Name := FileName;
  Data := TFile.Create(FileName);
end;

procedure TAudioData.Calculate_nBlockAlign;
begin
  nBlockAlign := nBitsPerSample div 8;
  if nBitsPerSample mod 8 <> 0 then  Inc(nBlockAlign);
  nBlockAlign := nBlockAlign*nChannels;
end;

procedure TAudioData.ReadSample(Number, Channel: LongInt; var Value: Integer);
var
  i: Byte;
  Mult, AbsValue: LongWord;
begin
  Calculate_nBlockAlign;
  Data.Position := Number*nBlockAlign + Channel*(nBlockAlign div nChannels);
  AbsValue := 0;
  Data.Read(AbsValue, nBlockAlign div nChannels);
  Mult := 1;
  for i := 1 to nBlockAlign div nChannels do
    Mult := Mult*256;
  if nBitsPerSample>8 then
    if AbsValue >= Trunc(Mult/2) then Value := AbsValue - Mult else Value := AbsValue
  else Value := AbsValue-128;
end;

procedure TAudioData.WriteSample(Number, Channel: LongInt; Value: Integer);
var
  K: Byte;
  N: Cardinal;
begin
  Calculate_nBlockAlign;
  Data.Position := Number*nBlockAlign + Channel*(nBlockAlign div nChannels);
  if Data.Position>Data.Size then
  begin
    K := 0;
    N := Data.Position + nBlockAlign div nChannels;
    Data.Position := Data.Size;
    while Data.Position<=N do Data.Write(K, 1);
    Data.Position := Number*nBlockAlign + Channel*(nBlockAlign div nChannels);
  end;
  if nBitsPerSample<=8 then Value := Value+128;
  Data.Write(Value, nBlockAlign div nChannels);
end;

function TAudioData.Extremum(Number, Channel: LongInt): Boolean;
var
  Smp1, Smp, Smp2: Integer;
begin
  if (Number = 0) or (Number + 1 = Data.Size div nBlockAlign) then
  begin
    Extremum := True;
    Exit;
  end;
  ReadSample(Number-1, Channel, Smp1);
  ReadSample(Number, Channel, Smp);
  ReadSample(Number+1, Channel, Smp2);
  if (Smp1<Smp)and(Smp>Smp2) or (Smp1>Smp)and(Smp<Smp2) then
    Extremum := True
  else
    Extremum := False;  
end;

destructor TAudioData.Destroy;
begin
  Data.Destroy;
  DeleteFile(Name);
  inherited Destroy;
end;

procedure CopyAudio(var AudioSource, AudioGeter: TAudioData; Start, Finish: Cardinal);
var
  i: Cardinal;
  Buf: array[0..63] of Byte;
begin
  AudioGeter.Data.Clear;
  AudioGeter.nChannels := AudioSource.nChannels;
  AudioGeter.nSamplesPerSec := AudioSource.nSamplesPerSec;
  AudioGeter.nBitsPerSample := AudioSource.nBitsPerSample;
  AudioGeter.Calculate_nBlockAlign;
  AudioSource.Data.Position := Start*AudioSource.nBlockAlign;
  for i := 1 to Abs(Finish-Start) do
  begin
    AudioSource.Data.Read(Buf, AudioSource.nBlockAlign);
    AudioGeter.Data.Write(Buf, AudioSource.nBlockAlign);
  end;
  AudioGeter.nChannels := AudioSource.nChannels;
  AudioGeter.nSamplesPerSec := AudioSource.nSamplesPerSec;
  AudioGeter.nBitsPerSample := AudioSource.nBitsPerSample;
end;

procedure InsertAudio(var AudioSource, AudioGeter: TAudioData; Start: Cardinal);
var
  i: Cardinal;
  Buf: Byte;
begin
  if AudioSource.Data.Size = 0 then Exit;
  AudioGeter.Data.Insert(Start*AudioGeter.nBlockAlign, AudioSource.Data.Size);
  AudioSource.Data.Position := 0;
  AudioGeter.Data.Position := Start*AudioGeter.nBlockAlign;
  for i := 1 to AudioSource.Data.Size do
  begin
    AudioSource.Data.Read(Buf, 1);
    AudioGeter.Data.Write(Buf, 1);
  end;
end;

procedure DeleteAudio(var AudioData: TAudioData; Start, Finish: Cardinal);
begin
  AudioData.Data.Delete(Start*AudioData.nBlockAlign, Abs(Finish-Start)*AudioData.nBlockAlign);
end;

procedure OverwriteAudio(var AudioSource, AudioGeter: TAudioData; Start: Cardinal);
var
  i: Cardinal;
  Buf: Byte;
begin
  if AudioSource.Data.Size = 0 then Exit;
  AudioSource.Data.Position := 0;
  AudioGeter.Data.Position := Start*AudioGeter.nBlockAlign;
  for i := 1 to AudioSource.Data.Size do
  begin
    AudioSource.Data.Read(Buf, 1);
    AudioGeter.Data.Write(Buf, 1);
  end;
end;

procedure MixAudio(var AudioSource, AudioGeter: TAudioData; Start: Cardinal);
var
  i, Channel, AudioSize: Cardinal;
  Value, MaxValue: Int64;
  Samp1, Samp2: Integer;
begin
  if AudioSource.Data.Size = 0 then Exit;
  AudioSize := AudioGeter.Data.Size div AudioGeter.nBlockAlign;
  MaxValue := 1; for i := 1 to AudioGeter.nBitsPerSample-1 do MaxValue := MaxValue*2;
  for i := 0 to AudioSource.Data.Size div AudioGeter.nBlockAlign - 1 do
    for Channel := 0 to AudioGeter.nChannels-1 do
    begin
      AudioSource.ReadSample(i, Channel, Samp1);
      if Start+i<AudioSize then
        AudioGeter.ReadSample(Start+i, Channel, Samp2)
      else
        Samp2 := 0;
      Value := Samp1 + Samp2;
      if (Value < -MaxValue)or(Value >= MaxValue) then
        Value := Trunc((Value)/2);
      AudioGeter.WriteSample(Start+i, Channel, Value);
    end;
end;

procedure ReverseAudio(var AudioData: TAudioData; Start, Count: Cardinal);
var
  i, AbsStart, AbsFinish, AbsCount: Cardinal;
  BufferStart: Cardinal;
  Buf: Int64;
  TempAudio: TAudioData;
begin
  TempAudio := TAudioData.Create;
  AbsStart := Start*AudioData.nBlockAlign;
  AbsCount := Count*AudioData.nBlockAlign;
  AbsFinish := AbsStart+AbsCount;
  i := AbsFinish;
  repeat
    if i-AbsStart>=MaxSizeOfBuffer then
      BufferStart := i - MaxSizeOfBuffer
    else
      BufferStart := AbsStart;
    AudioData.Data.Position := BufferStart;
    AudioData.Data.Read(Buf, 1);
    while i>BufferStart do
    begin
      i := i - AudioData.nBlockAlign;
      AudioData.Data.Position := i;
      AudioData.Data.Read(Buf, AudioData.nBlockAlign);
      TempAudio.Data.Write(Buf, AudioData.nBlockAlign);
    end;
  until i=AbsStart;
  AudioData.Data.Position := AbsStart;
  TempAudio.Data.Position := 0;
  for i := 1 to Count do
  begin
    TempAudio.Data.Read(Buf, AudioData.nBlockAlign);
    AudioData.Data.Write(Buf, AudioData.nBlockAlign);
  end;
  TempAudio.Destroy;
end;

procedure AddBrainWave(var AudioData: TAudioData; Start, Count, Freq1, Freq2: Integer);
var
  i, MaxAmplitude: Cardinal;
  T, TL, TR: Real;
  Freq: Integer;
  SampL, SampR: Integer;
begin
  if AudioData.nChannels = 1 then Exit;
  MaxAmplitude := 1;
  for i := 1 to AudioData.nBitsPerSample-1 do
    MaxAmplitude := MaxAmplitude*2;
  for i := Start to Start+Count-1 do
  begin
    Freq := Freq1 + Round((i-Start)*(Freq2-Freq1)/Count);
    T := 2*Pi/(AudioData.nSamplesPerSec/(Freq/100));
    TL := 2*Pi/(AudioData.nSamplesPerSec/(50+50*Freq/100));
    TR := 2*Pi/(AudioData.nSamplesPerSec/(50+50*Freq/100+Freq/100));
    AudioData.ReadSample(i, 0, SampL);
    AudioData.ReadSample(i, 1, SampR);
    SampL := Trunc(0.6*SampL+0.4*MaxAmplitude*Sin(i*TL));
    SampR := Trunc(0.6*SampR+0.4*MaxAmplitude*Sin(i*TR));
    AudioData.WriteSample(i, 0, SampL);
    AudioData.WriteSample(i, 1, SampR);
  end;
end;

procedure Normalize(var AudioData: TAudioData; Start, Count: Cardinal);
var
  i, MaxAmplitude, MaxVolume: Cardinal;
  Volume: Integer;
  K: Real;
  Channel: Word;
begin
  MaxAmplitude := 1;
  for i := 1 to AudioData.nBitsPerSample-1 do
    MaxAmplitude := MaxAmplitude*2;
  for Channel := 0 to AudioData.nChannels-1 do
  begin
    MaxVolume := 0;
    for i := Start to Start+Count-1 do
    begin
      AudioData.ReadSample(i, Channel, Volume);
      if Abs(Volume) > MaxVolume then MaxVolume := Abs(Volume);
    end;
    K := MaxAmplitude/MaxVolume;
    for i := Start to Start+Count-1 do
    begin
      AudioData.ReadSample(i, Channel, Volume);
      Volume := Round(Volume*K);
      AudioData.WriteSample(i, Channel, Volume);
    end;
  end;
end;

procedure SetSpeedOfAudio(var AudioData: TAudioData; Start, Count: Cardinal; Speed: Real);
var
  i, j, k, n, NewCount: Cardinal;
  Channel: Byte;
  Smp1, Smp2: Integer;
  Interval: Real;
  TempAudio: TAudioData;
  Buf: Int64;
begin
  if (Speed = 1) or (Speed = 0) then Exit;
  TempAudio := TAudioData.Create;
  TempAudio.nChannels := AudioData.nChannels;
  TempAudio.nSamplesPerSec := AudioData.nSamplesPerSec;
  TempAudio.nBitsPerSample := AudioData.nBitsPerSample;
  TempAudio.nBlockAlign := AudioData.nBlockAlign;
  NewCount := Round(Count/Speed);
  if Speed > 1 then
  begin
    i := NewCount;
    Interval := Speed;
    AudioData.Data.Position := Start*AudioData.nBlockAlign;
    while i<>0 do
    begin
      AudioData.Data.Read(Buf, AudioData.nBlockAlign);
      TempAudio.Data.Write(Buf, AudioData.nBlockAlign);
      AudioData.Data.Position := AudioData.Data.Position - AudioData.nBlockAlign + Trunc(Interval)*AudioData.nBlockAlign;
      Interval := Interval-Trunc(Interval)+Speed;
      Dec(i);
    end;
  end
  else
  begin
    Speed := 1/Speed;
    for Channel := 0 to AudioData.nChannels-1 do
    begin
      i := 0;
      j := 0;
      Interval := Speed;
      while i<>Count do
      begin
        AudioData.ReadSample(Start+i, Channel, Smp1);
        if i+1<>Count then
          AudioData.ReadSample(Start+i+1, Channel, Smp2)
        else
          Smp2 := Smp1;
        k := Trunc(Interval);
        for n := 0 to k-1 do
          TempAudio.WriteSample(j+n, Channel, Round(Smp1+(Smp2-Smp1)/k*n));
        Interval := Interval-Trunc(Interval)+Speed;
        Inc(i);
        Inc(j, k);
      end;
    end;
  end;
  DeleteAudio(AudioData, Start, Start+Count-1);
  InsertAudio(TempAudio, AudioData, Start);
  TempAudio.Destroy;
end;

function ChangeSpeedOfAudio(var AudioData: TAudioData; Start, Count: Cardinal; Speed: Real): Cardinal;
var
  i, j, k, n: Cardinal;
  Channel: Byte;
  Smp1, Smp2: Integer;
  Interval, FinalSpeed: Real;
  TempAudio: TAudioData;
  Buf: Int64;
begin
  if (Speed = 1) or (Speed = 0) then Exit;
  TempAudio := TAudioData.Create;
  TempAudio.nChannels := AudioData.nChannels;
  TempAudio.nSamplesPerSec := AudioData.nSamplesPerSec;
  TempAudio.nBitsPerSample := AudioData.nBitsPerSample;
  TempAudio.nBlockAlign := AudioData.nBlockAlign;
  FinalSpeed := Speed;
  if Speed > 1 then
  begin
    Speed := 1;
    Interval := Speed;
    AudioData.Data.Position  := Start*AudioData.nBlockAlign;
    while AudioData.Data.Position div AudioData.nBlockAlign < Start+Count do
    begin
      AudioData.Data.Read(Buf, AudioData.nBlockAlign);
      TempAudio.Data.Write(Buf, AudioData.nBlockAlign);
      AudioData.Data.Position := AudioData.Data.Position - AudioData.nBlockAlign + Trunc(Interval)*AudioData.nBlockAlign;
      Interval := Interval-Trunc(Interval)+Speed;
      Speed := Speed+Trunc(Interval)*(FinalSpeed-1)/Count;
    end;
  end
  else
  begin
    FinalSpeed := 1/FinalSpeed;
    for Channel := 0 to AudioData.nChannels-1 do
    begin
      i := 0;
      j := 0;
      Speed := 1;
      Interval := Speed;
      while i<>Count do
      begin
        AudioData.ReadSample(Start+i, Channel, Smp1);
        if i+1<>Count then
          AudioData.ReadSample(Start+i+1, Channel, Smp2)
        else
          Smp2 := Smp1;
        k := Trunc(Interval);
        for n := 0 to k-1 do
          TempAudio.WriteSample(j+n, Channel, Round(Smp1+(Smp2-Smp1)/k*n));
        Interval := Interval-Trunc(Interval)+Speed;
        Inc(i);
        Inc(j, k);
        Speed := Speed+(FinalSpeed-1)/Count;
      end;
    end;
  end;
  DeleteAudio(AudioData, Start, Start+Count-1);
  InsertAudio(TempAudio, AudioData, Start);
  ChangeSpeedOfAudio := TempAudio.Data.Size div TempAudio.nBlockAlign;
  TempAudio.Destroy;
end;

procedure SetnSamplesPerSec(var AudioData: TAudioData; Value: Cardinal);
var
  AudioSize: Cardinal;
begin
  if AudioData.nSamplesPerSec = Value then Exit;
  with AudioData do
    AudioSize := Data.Size div nBlockAlign;
  if AudioSize <> 0 then SetSpeedOfAudio(AudioData, 0, AudioSize, AudioData.nSamplesPerSec/Value);
  AudioData.nSamplesPerSec := Value;
end;

procedure SetnBitsPerSample(var AudioData: TAudioData; Value: Cardinal);
var
  AudioSize, Max1, Max2, i: Cardinal;
  Channel: Word;
  Smp: Integer;
  Mult: Real;
  TempAudio: TAudioData;
begin
  if AudioData.nBitsPerSample = Value then Exit;
  with AudioData do
    AudioSize := Data.Size div nBlockAlign;
  TempAudio := TAudioData.Create;
  TempAudio.nChannels := AudioData.nChannels;
  TempAudio.nSamplesPerSec := AudioData.nSamplesPerSec;
  TempAudio.nBitsPerSample := Value;
  TempAudio.Calculate_nBlockAlign;
  Max1 := 1; for i := 1 to AudioData.nBlockAlign div AudioData.nChannels do Max1 := Max1*256;
  Max2 := 1; for i := 1 to TempAudio.nBlockAlign div TempAudio.nChannels do Max2 := Max2*256;
  Mult := Max2/Max1;
  if AudioSize<>0 then
  begin
    for Channel := 0 to AudioData.nChannels-1 do
      for i := 0 to AudioSize-1 do
        begin
          AudioData.ReadSample(i, Channel, Smp);
          Smp := Trunc(Smp*Mult);
          TempAudio.WriteSample(i, Channel, Smp);
        end;
    AudioData.Data.Clear;
    OverwriteAudio(TempAudio, AudioData, 0);
  end;
  TempAudio.Destroy;
  AudioData.nBitsPerSample := Value;
  AudioData.Calculate_nBlockAlign;
end;

procedure SetnChannels(var AudioData: TAudioData; Value: Cardinal);
var
  AudioSize: Cardinal;
  TempAudio: TAudioData;
  i: Integer;
  Channel: Cardinal;
  Smp: Integer;
begin
  if AudioData.nChannels = Value then Exit;
  with AudioData do
    AudioSize := Data.Size div nBlockAlign;
  TempAudio := TAudioData.Create;
  TempAudio.nChannels := Value;
  TempAudio.nSamplesPerSec := AudioData.nSamplesPerSec;
  TempAudio.nBitsPerSample := AudioData.nBitsPerSample;
  TempAudio.Calculate_nBlockAlign;
  for i := 0 to AudioSize-1 do
    for Channel := 0 to Value-1 do
    begin
      if Channel < AudioData.nChannels then
        AudioData.ReadSample(i, Channel, Smp)
      else
        AudioData.ReadSample(i, AudioData.nChannels-1, Smp);
      TempAudio.WriteSample(i, Channel, Smp);
    end;
  AudioData.Data.Clear;
  AudioData.nChannels := Value;
  AudioData.Calculate_nBlockAlign;
  OverWriteAudio(TempAudio, AudioData, 0);
  TempAudio.Destroy;
end;

procedure SetVolumeOfAudio(var AudioData: TAudioData; Start, Count: Cardinal; Volume: Real);
var
  MaxValue: Cardinal;
  Value: Integer;
  i: Cardinal;
  Channel: Word;
begin
  MaxValue := 1;
  for i := 1 to AudioData.nBlockAlign div AudioData.nChannels do
    MaxValue := MaxValue*256;
  MaxValue := MaxValue div 2 - 1;
  for Channel := 0 to AudioData.nChannels-1 do
    for i := Start to Start+Count-1 do
    begin
      AudioData.ReadSample(i, Channel, Value);
      //Value := Trunc(Value*Exp(Volume/20));
      Value := Trunc(Value*Volume);
      if Abs(Value)>MaxValue then
        if Value<0 then Value := -MaxValue
        else Value := MaxValue;
      AudioData.WriteSample(i, Channel, Value);
    end;
end;

procedure Echo(var AudioData: TAudioData; Start, Count, Number, Delay: Cardinal; Volume: Real);
var
  TempAudio: TAudioData;
  i, j, DelaySmp: Cardinal;
  SummSmp: Int64;
  Mult: Real;
  Smp: Integer;
  Channel: Word;
  MaxValue: Cardinal;
begin
  for i := 1 to AudioData.nBlockAlign div AudioData.nChannels do
    MaxValue := MaxValue*256;
  MaxValue := MaxValue div 2 - 1;
  TempAudio := TAudioData.Create;
  TempAudio.nChannels := AudioData.nChannels;
  TempAudio.nSamplesPerSec := AudioData.nSamplesPerSec;
  TempAudio.nBitsPerSample := AudioData.nBitsPerSample;
  TempAudio.Calculate_nBlockAlign;
  DelaySmp := Round(Delay*AudioData.nSamplesPerSec/1000);
  for Channel := 0 to AudioData.nChannels-1 do
    for i := Start to Start+Count-1 do
    begin
      AudioData.ReadSample(i, Channel, Smp);
      SummSmp := Smp;
      Mult := Volume;
      for j := 1 to Number do
      begin
        if i-Start < DelaySmp*j then
          Smp := 0
        else
          AudioData.ReadSample(i-DelaySmp*j, Channel, Smp);
        SummSmp := SummSmp + Round(Mult*Smp);
        Mult := Mult*Volume;
      end;
      Smp := Round(SummSmp/(Number+1));
      if Abs(Smp)>MaxValue then
        if Smp<0 then Smp := -MaxValue
        else Smp := MaxValue;
      TempAudio.WriteSample(i-Start, Channel, Smp);
    end;
  OverwriteAudio(TempAudio, AudioData, Start);
  TempAudio.Destroy;
  Normalize(AudioData, Start, Count);
end;

procedure Reverberation(var AudioData: TAudioData; Start, Count, Number, Delay: Cardinal; Volume: Real);
var
  TempAudio: TAudioData;
  i, j, k, DelaySmp: Cardinal;
  SummSmp: Int64;
  SmpBuf: array[0..64] of Int64;
  Mult: Real;
  Smp: Integer;
  Channel: Word;
  MaxValue: Cardinal;
begin
  for i := 1 to AudioData.nBlockAlign div AudioData.nChannels do
    MaxValue := MaxValue*256;
  MaxValue := MaxValue div 2 - 1;
  TempAudio := TAudioData.Create;
  TempAudio.nChannels := AudioData.nChannels;
  TempAudio.nSamplesPerSec := AudioData.nSamplesPerSec;
  TempAudio.nBitsPerSample := AudioData.nBitsPerSample;
  TempAudio.Calculate_nBlockAlign;
  DelaySmp := Round(Delay*AudioData.nSamplesPerSec/1000);
  for Channel := 0 to AudioData.nChannels-1 do
    for i := Start to Start+Count-1 do
    begin
      for j := Number downto 0 do
      begin
        if i-Start < DelaySmp*j then
          Smp := 0
        else
          AudioData.ReadSample(i-DelaySmp*j, Channel, Smp);
        SmpBuf[j] := Smp;
      end;
      Mult := Volume;
      for j := 1 to Number do
      begin
        for k := 1 to Number do
          SmpBuf[k-1] := SmpBuf[k-1] + Round(SmpBuf[k]*Mult);
        Mult := Mult*Volume;
      end;
      Smp := Round(SmpBuf[0]/(Number+1));
      if Abs(Smp)>MaxValue then
        if Smp<0 then Smp := -MaxValue
        else Smp := MaxValue;
      TempAudio.WriteSample(i-Start, Channel, Smp);
    end;
  OverwriteAudio(TempAudio, AudioData, Start);
  TempAudio.Destroy;
  Normalize(AudioData, Start, Count);
end;

procedure ChangeVolumeOfAudio(var AudioData: TAudioData; Start, Count: Cardinal; Volume: Real);
var
  MaxValue: Cardinal;
  Value: Integer;
  i: Cardinal;
  FinalVolume: Real;
  Channel: Word;
begin
  MaxValue := 1;
  for i := 1 to AudioData.nBlockAlign div AudioData.nChannels do
    MaxValue := MaxValue*256;
  MaxValue := MaxValue div 2 - 1;
  FinalVolume := Volume;
  for Channel := 0 to AudioData.nChannels-1 do
  begin
    Volume := 1;
    for i := Start to Start+Count-1 do
    begin
      AudioData.ReadSample(i, Channel, Value);
      //Value := Trunc(Value*Exp(Volume/20));
      Value := Trunc(Value*Volume);
      if Abs(Value)>MaxValue then
        if Value<0 then Value := -MaxValue
        else Value := MaxValue;
      AudioData.WriteSample(i, Channel, Value);
      Volume := Volume + (FinalVolume-1)/Count;
    end;
  end;  
end;

procedure ReChangeVolumeOfAudio(var AudioData: TAudioData; Start, Count: Cardinal; Volume: Real);
var
  MaxValue: Cardinal;
  Value: Integer;
  i: Cardinal;
  FinalVolume: Real;
  Channel: Word;
begin
  MaxValue := 1;
  for i := 1 to AudioData.nBlockAlign div AudioData.nChannels do
    MaxValue := MaxValue*256;
  MaxValue := MaxValue div 2 - 1;
  FinalVolume := Volume;
  for Channel := 0 to AudioData.nChannels-1 do
  begin
    Volume := 0;
    for i := Start to Start+Count-1 do
    begin
      AudioData.ReadSample(i, Channel, Value);
      //Value := Trunc(Value*Exp(Volume/20));
      Value := Trunc(Value*Volume);
      if Abs(Value)>MaxValue then
        if Value<0 then Value := -MaxValue
        else Value := MaxValue;
      AudioData.WriteSample(i, Channel, Value);
      Volume := Volume + FinalVolume/Count;
    end;
  end;  
end;


end.
