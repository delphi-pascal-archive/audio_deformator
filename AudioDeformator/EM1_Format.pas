unit EM1_Format;

interface

uses
  SysUtils, AudioFormat;

type
  TEM1File = class(TAudioFile)
  public
    EM1Label: String;
    nChannels: Word;
    nSamplesPerSec: LongWord;
    nBytesPerSample: Word;
    nSamples: LongWord;
    procedure ReadAudioData(var AudioData: TAudioData);
    constructor Create(FileName: string; var AudioData: TAudioData);
    constructor Open(FileName: string);
  end;

implementation

constructor TEM1File.Create(FileName: string; var AudioData: TAudioData);
var
  Channel: Word;
  NumberOfBit, NumberOfSample, NumberOfSample0, i: Cardinal;
  Sample: Integer;
  Bit: Byte;
begin
  inherited Create(FileName);
  EM1Label := 'EM1 ';
  nChannels := AudioData.nChannels;
  nSamplesPerSec := AudioData.nSamplesPerSec;
  nBytesPerSample := AudioData.nBitsPerSample div 8;
  nSamples := AudioData.Data.Size div AudioData.nBlockAlign;
  WriteString(EM1Label, 4);
  Write(nChannels, 2);
  Write(nSamplesPerSec, 4);
  Write(nBytesPerSample, 2);
  Write(nSamples, 4);
  for Channel := 0 to nChannels-1 do
  begin
    NumberOfBit := Position*8;
    NumberOfSample0 := 0;
    NumberOfSample := 1;
    Bit := 0;
    while NumberOfSample < nSamples do
    begin
      while not AudioData.Extremum(NumberOfSample, Channel) do
        Inc(NumberOfSample);
      Inc(NumberOfSample);
      for i := 1 to NumberOfSample-NumberOfSample0 do
      begin
        WriteBit(NumberOfBit, Bit);
        Inc(NumberOfBit);
      end;
      Bit := 1 - Bit;
      NumberOfSample0 := NumberOfSample;
    end;
    NumberOfSample0 := 0;
    NumberOfSample := 1;
    while NumberOfSample < nSamples do
    begin
      while not AudioData.Extremum(NumberOfSample, Channel) do
        Inc(NumberOfSample);
      AudioData.ReadSample(NumberOfSample, Channel, Sample);
      Inc(NumberOfSample);
      Write(Sample, nBytesPerSample);
      NumberOfSample0 := NumberOfSample; 
    end;
  end;
end;

constructor TEM1File.Open(FileName: String);
begin
  inherited Open(FileName);
  ReadString(EM1Label, 4);
  Read(nChannels, 2);
  Read(nSamplesPerSec, 4);
  Read(nBytesPerSample, 2);
  Read(nSamples, 4);
end;

procedure TEM1File.ReadAudioData(var AudioData: TAudioData);
var
  Channel: Word;
  NumberOfBit, NumberOfSample, NumberOfSample0, i: Cardinal;
  Sample, Sample0, Sample1: Integer;
  Bit: Byte;
  Value, Mult: LongWord;
begin
  AudioData.Data.Clear;
  AudioData.nChannels := nChannels;
  AudioData.nSamplesPerSec := nSamplesPerSec;
  AudioData.nBitsPerSample := nBytesPerSample*8;
  AudioData.Calculate_nBlockAlign;
  Position := 16;
  Mult := 1;
  for i := 0 to nBytesPerSample-1  do Mult := Mult*256;
  for Channel := 0 to nChannels-1 do
  begin
    NumberOfBit := Position*8;
    for i := 0 to nSamples-1 do
    begin
      ReadBit(NumberOfBit, Bit);
      if Bit = 0 then Sample := -32768 else Sample := 32767;
      AudioData.WriteSample(i, Channel, Sample);
      Inc(NumberOfBit);
    end;
    NumberOfSample0 := 0;
    NumberOfSample := 0;
    Sample0 := 0;
    while NumberOfSample < nSamples do
    begin
      AudioData.ReadSample(NumberOfSample, Channel, Sample1);
      Sample := Sample1;
      while (Sample = Sample1)and(NumberOfSample < nSamples) do
      begin
        Inc(NumberOfSample);
        if NumberOfSample < nSamples then
          AudioData.ReadSample(NumberOfSample, Channel, Sample);
      end;
      Value := 0;
      Read(Value, nBytesPerSample);
      if Value >= Mult/2 then Sample := Value - Mult else Sample := Value; 
      for i := 0 to NumberOfSample-NumberOfSample0-1 do
      begin
        Sample1 := Sample0 + Round((Sample-Sample0)/2 - (Sample-Sample0)/2*Cos(i*Pi/(NumberOfSample-NumberOfSample0)));
        AudioData.WriteSample(NumberOfSample0+i, Channel, Sample1);
      end;
      NumberOfSample0 := NumberOfSample;
      Sample0 := Sample;
    end;
  end;
end;

end.
