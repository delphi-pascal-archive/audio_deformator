unit PCM_Format;

interface

uses
  SysUtils, AudioFormat;

type
  TPCMFile = class(TAudioFile)
  public
    RIFFLabel: String;
    RIFFSize: LongWord;
    fccType: String;
    fmt_Label: String;
    fmtSize: LongWord;
    formatTag: Word;
    nChannels: Word;
    nSamplesPerSec: LongWord;
    nAvgBytesPerSec: LongWord;
    nBlockAlign: Word;
    nBitsPerSample: Word;
    DataID: String;
    AdvDataBegin: LongWord; //*
    DataSize: LongWord;
    DataLabel: String;
    SndDataBegin: LongWord; //*
    nDataBytes: LongWord;
    constructor Open(FileName: string);
    function ReadSample(Number, Channel: LongInt): Integer;
    procedure WriteSample(Number, Channel: LongInt; Value: Integer);
    procedure ReadAudioData(var AudioData: TAudioData);
    constructor Create(FileName: string; var AudioData: TAudioData);
  private
    { Private declarations }
  end;
  
implementation

constructor TPCMFile.Open(FileName: String);
begin
  inherited Open(FileName);
  ReadString(RIFFLabel, 4);
  Read(RIFFSize, 4);
  ReadString(fccType, 4);
  ReadString(fmt_Label, 4);
  Read(fmtSize, 4);
  Read(formatTag, 2);
  Read(nChannels, 2);
  Read(nSamplesPerSec, 4);
  Read(nAvgBytesPerSec, 4);
  Read(nBlockAlign, 2);
  Read(nBitsPerSample, 2);
  Position :=  $14 + fmtSize;
  ReadString(DataLabel, 4);
  if DataLabel <> 'data' then
  begin
    DataId := DataLabel;
    Read(DataSize, 4);
    AdvDataBegin := Position;
    Position := Position + DataSize;
    ReadString(DataLabel, 4);
  end
  else
  begin
    DataID := '';
    DataSize := 0;
  end;
  Read(nDataBytes, 4);
  SndDataBegin := Position;
end;

function TPCMFile.ReadSample(Number, Channel: LongInt): Integer;
var
  i: Byte;
  Value, Mult: LongWord;
begin
  Position := SndDataBegin + Number*nBlockAlign + Channel*Trunc(nBlockAlign/nChannels);
  Value := 0;
  Read(Value, Trunc(nBlockAlign/nChannels));
  Mult := 1;
  for i := 0 to Trunc(nBlockAlign/nChannels)-1  do Mult := Mult*256;
  if nBitsPerSample>8 then
    if Value >= Mult/2 then ReadSample := Value - Mult else ReadSample := Value
  else
    ReadSample := Value-128;
end;

procedure TPCMFile.WriteSample(Number, Channel: LongInt; Value: Integer);
begin
  Position := SndDataBegin + Number*nBlockAlign + Channel*Trunc(nBlockAlign/nChannels);
  if nBitsPerSample<=8 then Value := Value+128;
  Write(Value, Trunc(nBlockAlign/nChannels));
end;

procedure TPCMFile.ReadAudioData(var AudioData: TAudioData);
const
  MaxBufSize = 65536;
var
  i: Cardinal;
  BufSize: Cardinal;
  Buf: array [0..MaxBufSize] of Byte;
begin
  AudioData.Data.Clear;
  Position := SndDataBegin;
  while Position<Size do
  begin
    if Size-Position>=MaxBufSize then BufSize := MaxBufSize else BufSize := Size-Position;
    Read(Buf, BufSize);
    AudioData.Data.Write(Buf, BufSize);
  end;
  AudioData.nChannels := nChannels;
  AudioData.nSamplesPerSec := nSamplesPerSec;
  AudioData.nBitsPerSample := nBitsPerSample;
  AudioData.Calculate_nBlockAlign;
end;

constructor TPCMFile.Create(FileName: string; var AudioData: TAudioData);
const
  MaxBufSize = 65536;
var
  i: Cardinal;
  BufSize: Cardinal;
  Buf: array [0..MaxBufSize] of Byte;
begin
  inherited Create(FileName);
  RIFFLabel := 'RIFF';
  RIFFSize := AudioData.Data.Size+4*3+2*2+4*2+2*2+4*2;
  fccType := 'WAVE';
  fmt_Label := 'fmt ';
  fmtSize := 16;
  formatTag := 1; //???
  nChannels := AudioData.nChannels;
  nSamplesPerSec := AudioData.nSamplesPerSec;
  nBlockAlign := AudioData.nBitsPerSample div 8;
  if AudioData.nBitsPerSample mod 8 <> 0 then  Inc(nBlockAlign);
  nBlockAlign := nBlockAlign*nChannels;
  nAvgBytesPerSec :=  nSamplesPerSec*nBlockAlign;
  nBitsPerSample := AudioData.nBitsPerSample;
  DataLabel := 'data';
  nDataBytes := AudioData.Data.Size;
  WriteString(RIFFLabel, 4);
  Write(RIFFSize, 4);
  WriteString(fccType, 4);
  WriteString(fmt_Label, 4);
  Write(fmtSize, 4);
  Write(formatTag, 2);
  Write(nChannels, 2);
  Write(nSamplesPerSec, 4);
  Write(nAvgBytesPerSec, 4);
  Write(nBlockAlign, 2);
  Write(nBitsPerSample, 2);
  WriteString(DataLabel, 4);
  Write(nDataBytes, 4);
  DataID := '';
  DataSize := 0;
  SndDataBegin := Position;
  AudioData.Data.Position := 0;
  while AudioData.Data.Position < AudioData.Data.Size do
  begin
    with AudioData.Data do
    begin
      if Size-Position>=MaxBufSize then BufSize := MaxBufSize else BufSize := Size-Position;
      Read(Buf, BufSize);
    end;
    Write(Buf, BufSize);
  end;
end;

end.
