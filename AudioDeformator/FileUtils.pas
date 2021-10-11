unit FileUtils;

interface

uses
  SysUtils;

const
  MaxSizeOfBuffer = 256*1024;

type
  TFile = class(TObject)
  private
    F: File of Byte;
    Name: String;
    Buffer: array[0..MaxSizeOfBuffer] of Byte;
    PositionOfBuffer: Cardinal;
    SizeOfBuffer: Cardinal;
  public
    Position: Cardinal;
    Size: Cardinal;
    constructor Open(FileName: String);
    constructor Create(FileName: String);
    destructor Destroy;
    procedure Clear;
    procedure ReadBit(Number: Cardinal; var Value: Byte);
    procedure Read(var Buf; Count: Cardinal);
    procedure ReadString(var Buf: String; Count: Cardinal);
    procedure WriteBit(Number: Cardinal; var Value: Byte);
    procedure Write(var Buf; Count: Cardinal);
    procedure WriteString(var Buf: String; Count: Cardinal);
    procedure Delete(Start, Count: Cardinal);
    procedure Insert(Start, Count: Cardinal);
  end;

implementation

constructor TFile.Open(FileName: String);
begin
  inherited Create;
  AssignFile(F, FileName);
  Name := FileName;
  Reset(F);
  Position := 0;
  PositionOfBuffer := 0;
  if FileSize(F)>=MaxSizeOfBuffer then SizeOfBuffer := MaxSizeOfBuffer else SizeOfBuffer := FileSize(F);
  BlockRead(F, Buffer, SizeOfBuffer);
  if PositionOfBuffer+SizeOfBuffer<FileSize(F) then Size := FileSize(F) else Size := PositionOfBuffer+SizeOfBuffer;
end;

constructor TFile.Create(FileName: String);
begin
  inherited Create;
  AssignFile(F, FileName);
  Name := FileName;
  ReWrite(F);
  Position := 0;
  PositionOfBuffer := 0;
  SizeOfBuffer := 0;
  Size := 0;
end;

procedure TFile.ReadBit(Number: Cardinal; var Value: Byte);
var
  PositionInByte, Mask, i: Byte;
begin
  Position := Number div 8;
  Read(Value, 1);
  PositionInByte := Number mod 8;
  Mask := 1;
  for i := 1 to PositionInByte do Mask := Mask*2;
  Value := Value and Mask;
  if Value <> 0 then Value := 1;
end;

procedure TFile.Read(var Buf; Count: Cardinal);
var
  i: Cardinal;
  P: PByteArray;
begin
  if Position>=Size then Position := Size-1;
  if Position+Count>Size then Count := Size - Position;
  if (Position<PositionOfBuffer)or(Position+Count>PositionOfBuffer+MaxSizeOfBuffer) then
  begin
    Seek(F, PositionOfBuffer);
    BlockWrite(F, Buffer, SizeOfBuffer);
    PositionOfBuffer := Position;
    if Size-Position>=MaxSizeOfBuffer then SizeOfBuffer := MaxSizeOfBuffer else SizeOfBuffer := Size - Position;
    Seek(F, PositionOfBuffer);
    if SizeOfBuffer<>0 then BlockRead(F, Buffer, SizeOfBuffer);
  end;
  P := @Buf;
  for i := 0 to Count-1 do P^[i] := Buffer[Position-PositionOfBuffer+i];
  Position := Position+Count;
end;

procedure TFile.ReadString(var Buf: String; Count: Cardinal);
var
  i: Cardinal;
  Ch: Char;
begin
  Buf := '';
  for i := 1 to Count do
  begin
    Read(Ch, 1);
    Buf := Buf + Ch;
  end;
end;

procedure TFile.WriteBit(Number: Cardinal; var Value: Byte);
var
  PositionInByte, Mask, Value2, i: Byte;
begin
  Position := Number div 8;
  Read(Value2, 1);
  PositionInByte := Number mod 8;
  Mask := 1;
  for i := 1 to PositionInByte do Mask := Mask*2;
  if Value = 0 then
    Value2 := Value2 and (255-Mask)
  else
    Value2 := Value2 or Mask;
  Position := Number div 8;
  Write(Value2, 1);    
end;

procedure TFile.Write(var Buf; Count: Cardinal);
var
  i: Cardinal;
  P: PByteArray;
begin
  if Position>Size then Position := Size;
  if (Position<PositionOfBuffer)or(Position+Count>PositionOfBuffer+MaxSizeOfBuffer) then
  begin
    Seek(F, PositionOfBuffer);
    BlockWrite(F, Buffer, SizeOfBuffer);
    PositionOfBuffer := Position;
    if Size-Position>=MaxSizeOfBuffer then SizeOfBuffer := MaxSizeOfBuffer else SizeOfBuffer :=Size-Position;
    Seek(F, PositionOfBuffer);
    if SizeOfBuffer<>0 then BlockRead(F, Buffer, SizeOfBuffer);
  end;
  if Position+Count>PositionOfBuffer+SizeOfBuffer then
    begin
      SizeOfBuffer := Position-PositionOfBuffer+Count;
      Size := PositionOfBuffer+SizeOfBuffer;
    end;
  P := @Buf;
  for i := 0 to Count-1 do Buffer[Position-PositionOfBuffer+i] := P^[i];
  Position := Position+Count;
end;

procedure TFile.WriteString(var Buf: String; Count: Cardinal);
var
  i: Cardinal;
  Ch: Char;
begin
  for i := 1 to Count do
  begin
    Ch := Buf[i];
    Write(Ch, 1);
  end;
end;

procedure TFile.Clear;
begin
  PositionOfBuffer := 0;
  SizeOFBuffer := 0;
  Position := 0;
  Seek(F, 0);
  if FileSize(F)<>0 then Truncate(F);
  Size := 0;  
end;

procedure TFile.Delete(Start, Count: Cardinal);
const
  MaxBufSize = 128*1024;
var
  BufSize: Cardinal;
  Buf: array [0..MaxBufSize] of Byte;
  i: Cardinal;
begin
  if Start>Size then Exit;
  if Start+Count>Size then Count := Size-Start;
  Seek(F, PositionOfBuffer);
  BlockWrite(F, Buffer, SizeOfBuffer);
  Position := Start+Count;
  if Size-Position>=MaxBufSize then BufSize := MaxBufSize else BufSize := Size-Position;
  while BufSize<>0 do
  begin
    Seek(F, Position);
    BlockRead(F, Buf, BufSize);
    Seek(F, Start+Position-(Start+Count));
    BlockWrite(F, Buf, BufSize);
    Position := Position+BufSize;
    if Size-Position>=MaxBufSize then BufSize := MaxBufSize else BufSize := Size-Position;
  end;
  Seek(F, Size-Count);
  if Start<>Size then Truncate(F);
  Size := FileSize(F);
  PositionOfBuffer := 0;
  Position := 0;
  if Size>=MaxSizeOfBuffer then SizeOfBuffer := MaxSizeOfBuffer else SizeOfBuffer :=Size;
  Seek(F, 0);
  if SizeOfBuffer<>0 then BlockRead(F, Buffer, SizeOfBuffer);
end;

procedure TFile.Insert(Start, Count: Cardinal);
const
  MaxBufSize = 128*1024;
var
  BufSize: Cardinal;
  Buf: array [0..MaxBufSize] of Byte;
  i, PreviusSize: Cardinal;
begin
  if Start>Size then Start := Size;
  if Count = 0 then Exit;
  PreviusSize := Size;
  Position := Size;
  for i := 1 to Count do Write(Buf, 1);
  Seek(F, PositionOfBuffer);
  BlockWrite(F, Buffer, SizeOfBuffer);
  Position := PreviusSize;
  while Position <> Start do
  begin
    if Position-Start<MaxBufSize then
    begin
      Position := Start;
      BufSize := Position-Start;
    end
    else
    begin
      Position := Position-MaxBufSize;
      BufSize := MaxBufSize;
    end;
    Seek(F, Position);
    BlockRead(F, Buf, BufSize);
    Seek(F, Position+Count);
    BlockWrite(F, Buf, BufSize);
  end;
  PositionOfBuffer := 0;
  Position := 0;
  if Size>=MaxSizeOfBuffer then SizeOfBuffer := MaxSizeOfBuffer else SizeOfBuffer :=Size;
  Seek(F, 0);
  if SizeOfBuffer<>0 then BlockRead(F, Buffer, SizeOfBuffer);
end;

destructor TFile.Destroy;
begin
  Seek(F, PositionOfBuffer);
  BlockWrite(F, Buffer, SizeOfBuffer);
  CloseFile(F);
  inherited Destroy;
end;

end.
