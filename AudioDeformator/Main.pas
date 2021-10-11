unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Spin,
  MMSystem, ShellApi, FileUtils, AudioFormat,
  PCM_Format, MP3_Format, EM1_Format, Menus, Help;

type
  TMainForm = class(TForm)
    HomePageLink: TStaticText;
    AboutButton: TButton;
    OutDeviceComboBox: TComboBox;
    InDeviceComboBox: TComboBox;
    TrackBar: TTrackBar;
    PlayButton: TSpeedButton;
    PauseButton: TSpeedButton;
    RecordButton: TSpeedButton;
    OpenButton: TSpeedButton;
    SaveButton: TSpeedButton;
    TimePosition: TStaticText;
    PositionSpinEdit: TSpinEdit;
    OpenDialog: TOpenDialog;
    Marker1: TBitBtn;
    Marker2: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    SetMarkerButton: TButton;
    DeleteMarkersButton: TButton;
    CopyButton: TBitBtn;
    CutButton: TBitBtn;
    ClearButton: TBitBtn;
    PasteButton: TBitBtn;
    PasteFileButton: TBitBtn;
    PasteModeText: TStaticText;
    PasteModeComboBox: TComboBox;
    DeleteButton: TBitBtn;
    TabSheet3: TTabSheet;
    ReverseButton: TBitBtn;
    SpeedEdit: TSpinEdit;
    SetSpeedText: TStaticText;
    VolumeEdit: TSpinEdit;
    SetVolumeText: TStaticText;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    ConstantBitrateComboBox: TComboBox;
    nSamplesPerSecText: TStaticText;
    nSamplesPerSecButton: TButton;
    nSamplesBox: TComboBox;
    nBitsBox: TComboBox;
    nBitsPerSampleButton: TButton;
    nBitsPerSampleText: TStaticText;
    nChannelsText: TStaticText;
    nChannelsButton: TButton;
    nChannelsBox: TComboBox;
    StaticText1: TStaticText;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    AverageBitrateComboBox: TComboBox;
    VariableBitRateComboBox: TComboBox;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StereoModeComboBox: TComboBox;
    EffectButton: TButton;
    EffectBox: TComboBox;
    SetSpeedBitBtn: TBitBtn;
    ChangeSpeedButton: TBitBtn;
    SetVolumeBitBtn: TBitBtn;
    ChangeVolumeBitBtn: TBitBtn;
    NormalizeBitBtn: TBitBtn;
    PaintBox1: TPaintBox;
    WaveOutButton: TSpeedButton;
    WaveInButton: TSpeedButton;
    SilenceTime: TSpinEdit;
    PasteSilenceButton: TButton;
    CopyToFileButton: TBitBtn;
    Memo1: TMemo;
    UndoButton: TBitBtn;
    EMailButton: TSpeedButton;
    HelpButton: TBitBtn;
    TabSheet6: TTabSheet;
    SaveDialog: TSaveDialog;
    PageControl3: TPageControl;
    TabSheet7: TTabSheet;
    StaticText5: TStaticText;
    nResponsesEdit: TSpinEdit;
    ResponseTimeEdit: TSpinEdit;
    ResponseVolumeEdit: TSpinEdit;
    StaticText6: TStaticText;
    StaticText7: TStaticText;
    StaticText8: TStaticText;
    StaticText9: TStaticText;
    TabSheet8: TTabSheet;
    nEchosEdit: TSpinEdit;
    DelayEdit: TSpinEdit;
    EchoVolumeEdit: TSpinEdit;
    StaticText10: TStaticText;
    StaticText11: TStaticText;
    StaticText12: TStaticText;
    StaticText13: TStaticText;
    StaticText14: TStaticText;
    TabSheet9: TTabSheet;
    BrainWaveButton: TButton;
    BWFreqEdit1: TSpinEdit;
    StaticText15: TStaticText;
    BWFreqEdit2: TSpinEdit;
    StaticText16: TStaticText;
    StaticText17: TStaticText;
    Left10Button: TButton;
    Right10Button: TButton;
    SSelButton: TButton;
    FSelButton: TButton;
    StaticText4: TStaticText;
    UndoCheckBox: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure OpenButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PlayButtonClick(Sender: TObject);
    procedure PauseButtonClick(Sender: TObject);
    procedure RecordButtonClick(Sender: TObject);
    procedure TrackBarChange(Sender: TObject);
    procedure PositionSpinEditChange(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure SetMarkerButtonClick(Sender: TObject);
    procedure DeleteMarkersButtonClick(Sender: TObject);
    procedure CopyButtonClick(Sender: TObject);
    procedure CutButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure PasteButtonClick(Sender: TObject);
    procedure ReverseButtonClick(Sender: TObject);
    procedure SetSpeedButtonClick(Sender: TObject);
    procedure ChangePropertie(Sender: TObject);
    procedure AboutButtonClick(Sender: TObject);
    procedure HomePageLinkClick(Sender: TObject);
    procedure SetVolumeButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure NormalizeButtonClick(Sender: TObject);
    procedure PasteSilenceButtonClick(Sender: TObject);
    procedure SetSpeedBitBtnClick(Sender: TObject);
    procedure ChangeSpeedButtonClick(Sender: TObject);
    procedure SetVolumeBitBtnClick(Sender: TObject);
    procedure ChangeVolumeBitBtnClick(Sender: TObject);
    procedure NormalizeBitBtnClick(Sender: TObject);
    procedure EffectButtonClick(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure WaveOutButtonClick(Sender: TObject);
    procedure WaveInButtonClick(Sender: TObject);
    procedure CopyToFileButtonClick(Sender: TObject);
    procedure UndoButtonClick(Sender: TObject);
    procedure EMailButtonClick(Sender: TObject);
    procedure BrainWaveButtonClick(Sender: TObject);
    procedure Left10ButtonClick(Sender: TObject);
    procedure SSelButtonClick(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
    procedure UndoCheckBoxClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure SetAudioPosition;
    procedure SetMarker;
    procedure DeleteMarkers;
    procedure PaintAudioGraph;
    procedure SaveUndoInfo;
  end;

type
  TPlayThread = class(TThread)
  public
    WaveOut: HWaveOut;
    procedure Execute; override;
  end;
  TRecordThread = class(TThread)
  public
    WaveIn: HWaveIn;
    procedure Execute; override;
  end;

var
  MainForm: TMainForm;
  Status: String;
  AudioPosition: Cardinal;
  AudioData: TAudioData;
  AudioClipBoard: TAudioData;
  PlayThread: TPlayThread;
  RecordThread: TRecordThread;
  Selection: record
    Start: Cardinal;
    Finish: Cardinal;
    StartExists: Boolean;
    FinishExists: Boolean;
  end;
  UndoInfo: record
    Selection: record
      Start: Cardinal;
      Finish: Cardinal;
      StartExists: Boolean;
      FinishExists: Boolean;
    end;
    AudioPosition: Cardinal;
    AudioData: TAudioData;
  end;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
var
  WaveOutCaps: TWaveOutCaps;
  WaveInCaps: TWaveInCaps;
  i: Cardinal;
begin
  BorderIcons := BorderIcons - [biMaximize];
  AudioData := TAudioData.Create;
  AudioClipBoard := TAudioData.Create;
  with AudioData do
  begin
    nChannels := 2;
    nBitsPerSample := 16;
    nSamplesPerSec := 44100;
    Calculate_nBlockAlign;
  end;
  AudioPosition := 0;
  if WaveOutGetNumDevs<>0 then
  begin
    for i := 0 to WaveOutGetNumDevs-1 do
    begin
      WaveOutGetDevCaps(i, @WaveOutCaps, SizeOf(TWaveOutCaps));
      OutDeviceComboBox.Items.Add(PChar(@WaveOutCaps.szPname));
    end;
    OutDeviceComboBox.ItemIndex := 0;
  end;
  if WaveInGetNumDevs<>0 then
  begin
    for i := 0 to WaveInGetNumDevs-1 do
    begin
      WaveInGetDevCaps(i, @WaveInCaps, SizeOf(TWaveInCaps));
      InDeviceComboBox.Items.Add(PChar(@WaveInCaps.szPname));
    end;
    InDeviceComboBox.ItemIndex := 0;
  end;
  AudioData.Calculate_nBlockAlign;
  UndoInfo.AudioData := TAudioData.Create;
  Status := 'starting';
end;

procedure TMainForm.SetAudioPosition;
var
  AudioSize, Long: Cardinal;
  S, S2: String;
begin
  with AudioData do AudioSize := Data.Size div nBlockAlign;
  if AudioSize = 0 then Exit;
  if AudioSize<TrackBar.Width then TrackBar.Max :=  AudioSize else TrackBar.Max := TrackBar.Width;
  with PositionSpinEdit do
  begin
    Value := AudioPosition;
    MinValue := 0;
    MaxValue := AudioSize;
  end;
  if TrackBar.Position <> Round(AudioPosition*TrackBar.Max/AudioSize) then TrackBar.Position := Round(AudioPosition*TrackBar.Max/AudioSize);
  S2 := '';
  Long := Trunc(AudioPosition/AudioData.nSamplesPerSec);
  Str(Trunc(Long/3600), S);
  Long := Long - Trunc(Long/3600)*3600;
  S2 := S2 + S +':';
  Str(Trunc(Long/60), S);
  Long := Long - Trunc(Long/60)*60;
  if Length(S)=1 then S2 := S2 + '0';
  S2 := S2 + S +':';
  Str(Long, S);
  if Length(S)=1 then S2 := S2 + '0';
  S2 := S2 + S +' / ';
  Long := Trunc(AudioSize/AudioData.nSamplesPerSec);
  Str(Trunc(Long/3600), S);
  Long := Long - Trunc(Long/3600)*3600;
  S2 := S2 + S +':';
  Str(Trunc(Long/60), S);
  Long := Long - Trunc(Long/60)*60;
  if Length(S)=1 then S2 := S2 + '0';
  S2 := S2 + S +':';
  Str(Long, S);
  if Length(S)=1 then S2 := S2 + '0';
  S2 := S2 + S + '      ';
  if TimePosition.Caption<>S2 then TimePosition.Caption := S2;
  PaintBox1.Repaint;
end;

procedure TMainForm.SetMarker;
var
  AudioSize: Cardinal;
begin
  if (Status = 'starting') then Exit;
  with AudioData do AudioSize := Data.Size div nBlockAlign;
  with Selection do
  begin
    if (AudioPosition=Start)and(StartExists) or (AudioPosition=Finish)and(FinishExists) then Exit;
    if not StartExists then
    begin
      Start := AudioPosition;
      StartExists := True;
      Marker1.Left := 8+Round(Start*(TrackBar.Max-20)/AudioSize);
      Marker1.Visible := True;
      Exit;
    end;
    if (StartExists) and (not FinishExists) then
    begin
      if AudioPosition>Start then
        Finish := AudioPosition
      else
      begin
        Finish := Start;
        Start := AudioPosition;
      end;
      FinishExists := True;
      TrackBar.SelStart := Round(Start*TrackBar.Max/AudioSize);
      TrackBar.SelEnd := Round(Finish*TrackBar.Max/AudioSize);
      Marker1.Left := 8+Round(Start*(TrackBar.Max-20)/AudioSize);
      Marker1.Visible := True;
      Marker2.Left := 8+Round(Finish*(TrackBar.Max-20)/AudioSize);
      Marker2.Visible := True;
      Exit;
    end;
    if (StartExists) and (FinishExists) then
    begin
      if AudioPosition<Start then
        Start := AudioPosition
      else
        if AudioPosition>Finish then
          Finish := AudioPosition;
      TrackBar.SelStart := Round(Start*TrackBar.Max/AudioSize);
      TrackBar.SelEnd := Round(Finish*TrackBar.Max/AudioSize);
      Marker1.Left := 8+Round(Start*(TrackBar.Max-20)/AudioSize);
      Marker1.Visible := True;
      Marker2.Left := 8+Round(Finish*(TrackBar.Max-20)/AudioSize);
      Marker2.Visible := True;
      Exit;
    end;
  end;
end;

procedure TMainForm.DeleteMarkers;
begin
  Selection.StartExists := False;
  Selection.FinishExists := False;
  Marker1.Visible := False;
  Marker2.Visible := False;
  TrackBar.SelStart := 0;
  TrackBar.SelEnd := 0;
end;

procedure TMainForm.OpenButtonClick(Sender: TObject);
var
  FileName, S, Ext: String;
  i: Byte;
  PCM: TPCMFile;
  MP3: TMP3File;
  EM1: TEM1File;
begin
  if (Status<>'starting')and(Status<>'waiting') then Exit;
  if OpenDialog.Execute then FileName := OpenDialog.FileName else Exit;
  Status := 'opening';
  AudioData.Data.Clear;
  if GetFileAttributes(PChar(FileName)) and FILE_ATTRIBUTE_READONLY = FILE_ATTRIBUTE_READONLY then
    SetFileAttributes(PChar(FileName), GetFileAttributes(PChar(FileName)) xor FILE_ATTRIBUTE_READONLY);
  Ext := ExtractFileExt(FileName);
  for i := 1 to Length(Ext) do Ext[i] := UpCase(Ext[i]);
  if Ext = '.WAV' then
  begin
    PCM := TPCMFile.Open(FileName);
    PCM.ReadAudioData(AudioData);
    PCM.Destroy;
  end;
  if Ext = '.MP3' then
  begin
    MP3 := TMP3File.Open(FileName);
    MP3.ReadAudioData(AudioData);
    MP3.Destroy;
  end;
  if Ext = '.EM1' then
  begin
    EM1 := TEM1File.Open(FileName);
    EM1.ReadAudioData(AudioData);
    EM1.Destroy;
  end;
  Str(AudioData.nChannels, S);
  nChannelsText.Caption := S + ' channels';
  Str(AudioData.nBitsPerSample, S);
  nBitsPerSampleText.Caption := S + ' bits';
  Str(AudioData.nSamplesPerSec, S);
  nSamplesPerSecText.Caption := S + ' Hz';
  AudioPosition := 0;
  AudioData.Calculate_nBlockAlign;
  SetAudioPosition;
  DeleteMarkers;
  Status := 'waiting';
end;

procedure TMainForm.PlayButtonClick(Sender: TObject);
begin
  if Status<>'waiting' then Exit;
  if OutDeviceComboBox.ItemIndex = -1 then Exit;
  if AudioPosition*AudioData.nBlockAlign >= AudioData.Data.Size then Exit;
  Status := 'playing';
  PlayThread := TPlayThread.Create(False);
end;

procedure TPlayThread.Execute;
const
  BlockSize = 1024*24;
var
  hEvent: THandle;
  WaveFormatEx: TWaveFormatEx;
  WaveHdr: array [0..1] of TWaveHdr;
  Buf: array [0..1] of array [0..BlockSize-1] of Byte;
  i: Cardinal;
begin
  with WaveFormatEx do
  begin
    wFormatTag := WAVE_FORMAT_PCM;
    nChannels := AudioData.nChannels;
    nSamplesPerSec := AudioData.nSamplesPerSec;
    wBitsPerSample := AudioData.nBitsPerSample;
    nBlockAlign := wBitsPerSample div 8 * nChannels;
    nAvgBytesPerSec := nSamplesPerSec * nBlockAlign;
    cbSize := 0;
  end;
  hEvent := CreateEvent(nil, False, False, nil);
  if WaveOutOpen(@WaveOut, MainForm.OutDeviceComboBox.ItemIndex , @WaveFormatEx, hEvent, 0, CALLBACK_EVENT) <> MMSYSERR_NOERROR then
  begin
    Status := 'waiting';
    CloseHandle(hEvent);
    Terminate;
    Exit;
  end;
  MainForm.PlayButton.Flat := True;
  for i := 0 to 1 do
  begin
    WaveHdr[i].lpData := @Buf[i];
    WaveHdr[i].dwBufferLength := BlockSize;
    AudioData.Data.Position := AudioPosition*AudioData.nBlockAlign;
    if i<>1 then
    begin
      AudioData.Data.Read(Buf[i], BlockSize);
      AudioPosition := AudioPosition + BlockSize div AudioData.nBlockAlign;
      if AudioPosition*AudioData.nBlockAlign >= AudioData.Data.Size then AudioPosition := AudioData.Data.Size div AudioData.nBlockAlign;
    end;
    WaveOutPrepareHeader(WaveOut, @WaveHdr[i], SizeOf(TWaveHdr));
  end;
  i := 0;
  while (not Terminated) and (AudioData.Data.Position<AudioData.Data.Size) do
  begin
    WaveOutWrite(WaveOut, @WaveHdr[i], SizeOf(TWaveHdr));
    WaitForSingleObject(hEvent, INFINITE);
    i := i xor 1;
    AudioData.Data.Position := AudioPosition*AudioData.nBlockAlign;
    AudioData.Data.Read(Buf[i], BlockSize);
    AudioPosition := AudioPosition + (BlockSize div AudioData.nBlockAlign);
    if AudioPosition*AudioData.nBlockAlign >= AudioData.Data.Size then AudioPosition := AudioData.Data.Size div AudioData.nBlockAlign;
    MainForm.SetAudioPosition;
  end;
  WaveOutReset(WaveOut);
  for i := 0 to 1 do WaveOutUnprepareHeader(WaveOut, @WaveHdr[i], SizeOf(WaveHdr));
  WaveOutClose(WaveOut);
  CloseHandle(hEvent);
  if not Terminated then Terminate;
  MainForm.PlayButton.Flat := False;
  Status := 'waiting';
end;


procedure TMainForm.RecordButtonClick(Sender: TObject);
begin
  if (Status<>'waiting')and(Status<>'starting') then Exit;
  if InDeviceComboBox.ItemIndex = -1 then Exit;
  Status := 'recording';
  RecordThread := TRecordThread.Create(False);
end;

procedure TRecordThread.Execute;
const
  BlockSize = 1024*24;
  BufNumber = 8;
var
  hEvent: THandle;
  WaveFormatEx: TWaveFormatEx;
  WaveHdr: array [0..BufNumber-1] of TWaveHdr;
  Buf: array [0..BufNumber-1] of array [0..BlockSize-1] of Byte;
  i: Cardinal;
begin
  with WaveFormatEx do
  begin
    wFormatTag := WAVE_FORMAT_PCM;
    nChannels := AudioData.nChannels;
    nSamplesPerSec := AudioData.nSamplesPerSec;
    wBitsPerSample := AudioData.nBitsPerSample;
    nBlockAlign := wBitsPerSample div 8 * nChannels;
    nAvgBytesPerSec := nSamplesPerSec * nBlockAlign;
    cbSize := 0;
  end;
  hEvent := CreateEvent(nil, False, False, nil);
  if WaveInOpen(@WaveIn, MainForm.InDeviceComboBox.ItemIndex , @WaveFormatEx, hEvent, 0, CALLBACK_EVENT) <> MMSYSERR_NOERROR then
  begin
    Status := 'waiting';
    CloseHandle(hEvent);
    Terminate;
    Exit;
  end;
  MainForm.RecordButton.Flat := True;
  for i := 0 to BufNumber-1 do
  begin
    WaveHdr[i].lpData := @Buf[i];
    WaveHdr[i].dwBufferLength := BlockSize;
    WaveInPrepareHeader(WaveIn, @WaveHdr[i], SizeOf(TWaveHdr));
  end;
  WaveInStart(WaveIn);
  WaitForSingleObject(hEvent, INFINITE);
  for i := 0 to BufNumber-1 do
    WaveInAddBuffer(WaveIn, @WaveHdr[i], SizeOf(TWaveHdr));
  i := BufNumber-1;
  while not Terminated do
  begin
    if i = BufNumber-1 then i := 0 else Inc(i);
    if (WaveHdr[i].dwFlags and WHDR_DONE) <> WHDR_DONE then
      WaitForSingleObject(hEvent, INFINITE);
    AudioData.Data.Position := AudioPosition*AudioData.nBlockAlign;
    AudioData.Data.Write(Buf[i], WaveHdr[i].dwBytesRecorded);
    AudioPosition := AudioPosition + (WaveHdr[i].dwBytesRecorded div AudioData.nBlockAlign);
    WaveInAddBuffer(WaveIn, @WaveHdr[i], SizeOf(TWaveHdr));
    MainForm.SetAudioPosition;
  end;
  WaveInReset(WaveIn);
  for i := 0 to BufNumber-1 do
    WaveInUnprepareHeader(WaveIn, @WaveHdr[i], SizeOf(WaveHdr));
  WaveInClose(WaveIn);
  CloseHandle(hEvent);
  if not Terminated then Terminate;
  with MainForm.PositionSpinEdit do
  begin
    Value := AudioPosition;
    MinValue := 0;
    MaxValue := AudioData.Data.Size div AudioData.nBlockAlign;;
  end;
  MainForm.RecordButton.Flat := False;
  Status := 'waiting';
end;

procedure TMainForm.PauseButtonClick(Sender: TObject);
begin
  if Status = 'playing' then PlayThread.Terminate;
  if Status = 'recording' then RecordThread.Terminate;
end;

procedure TMainForm.TrackBarChange(Sender: TObject);
var
  AudioSize: Cardinal;
begin
  if Status<>'waiting' then Exit;
  with AudioData do
    AudioSize := Data.Size div nBlockAlign;
  if TrackBar.Position <> Round(AudioPosition*TrackBar.Max/AudioSize) then
    begin
      AudioPosition := Round(TrackBar.Position/TrackBar.Max*AudioSize);
      SetAudioPosition;
    end;  
end;

procedure TMainForm.PositionSpinEditChange(Sender: TObject);
begin
  if Status<>'waiting' then Exit;
  AudioPosition := PositionSpinEdit.Value;
  SetAudioPosition;
end;

procedure TMainForm.SaveButtonClick(Sender: TObject);
var
  FileName, Ext, EncMode, StereoMode, BitRate: String;
  i: Byte;
  Code: Integer;
  PCM: TPCMFile;
  MP3: TMP3File;
  EM1: TEM1File;
begin
  if Status<>'waiting' then Exit;
  if SaveDialog.Execute then
    FileName := SaveDialog.FileName else Exit;
  Ext := ExtractFileExt(FileName);
  for i := 1 to Length(Ext) do Ext[i] := UpCase(Ext[i]);
  if Ext = '.WAV' then
  begin
    PCM := TPCMFile.Create(FileName, AudioData);
    PCM.Destroy;
  end;
  if Ext = '.MP3' then
  begin
    if RadioButton1.Checked then
    begin
      BitRate := ConstantBitRateComboBox.Text;
      EncMode := '-b';
    end;
    if RadioButton2.Checked then
    begin
      BitRate := AverageBitRateComboBox.Text;
      EncMode := '--abr';
    end;
    if RadioButton3.Checked then
    begin
      Str(VariableBitrateComboBox.ItemIndex, BitRate);
      EncMode := '-V';
    end;
    case StereoModeComboBox.ItemIndex of
      0: StereoMode := 's';
      1: StereoMode := 'j';
      2: StereoMode := 'f';
      3: StereoMode := 'd';
      4: StereoMode := 'm';
    end;
    MP3 := TMP3File.Create(FileName, AudioData, BitRate, EncMode, StereoMode);
    MP3.Destroy;
  end;
  if Ext = '.EM1' then
  begin
    EM1 := TEM1File.Create(FileName, AudioData);
    EM1.Destroy;
  end;
end;

procedure TMainForm.SetMarkerButtonClick(Sender: TObject);
begin
  SetMarker;
end;

procedure TMainForm.DeleteMarkersButtonClick(Sender: TObject);
begin
  DeleteMarkers;
end;

procedure TMainForm.CopyButtonClick(Sender: TObject);
var
  AudioSize: Cardinal;
  S: String;
begin
  if Status<>'waiting' then Exit;
  Status := 'editing';
  with AudioData do
    AudioSize := Data.Size div nBlockAlign;
  with Selection do
  begin
    if not StartExists or not FinishExists then
    begin
      DeleteMarkers;
      Start := 0;
      Finish := AudioSize-1;
    end;
    CopyAudio(AudioData, AudioClipBoard, Start, Finish);
  end;
  Str(AudioClipBoard.Data.Size div AudioClipBoard.nBlockAlign div AudioClipBoard.nSamplesPerSec, S);
  Memo1.Text := 'В буффере ' + S + ' сек.';
  Status := 'waiting';
end;

procedure TMainForm.DeleteButtonClick(Sender: TObject);
var
  AudioSize: Cardinal;
begin
  if Status<>'waiting' then Exit;
  Status := 'editing';
  SaveUndoInfo;
  with AudioData do
    AudioSize := Data.Size div nBlockAlign;
  with Selection do
  begin
    if not StartExists or not FinishExists then
    begin
      DeleteMarkers;
      Start := 0;
      Finish := AudioSize-1;
    end;
    DeleteAudio(AudioData, Start, Finish);
    DeleteMarkers;
    AudioPosition := Start;
    SetAudioPosition;
  end;
  Status := 'waiting';
end;

procedure TMainForm.CutButtonClick(Sender: TObject);
var
  AudioSize: Cardinal;
  S: String;
begin
  if Status<>'waiting' then Exit;
  Status := 'editing';
  SaveUndoInfo;
  with AudioData do
    AudioSize := Data.Size div nBlockAlign;
  with Selection do
  begin
    if not StartExists or not FinishExists then
    begin
      DeleteMarkers;
      Start := 0;
      Finish := AudioSize-1;
    end;
    CopyAudio(AudioData, AudioClipBoard, Start, Finish);
    DeleteAudio(AudioData, Start, Finish);
    DeleteMarkers;
    AudioPosition := Start;
    SetAudioPosition;
  end;
  Str(AudioClipBoard.Data.Size div AudioClipBoard.nBlockAlign div AudioClipBoard.nSamplesPerSec, S);
  Memo1.Text :=  'В буффере ' + S + ' сек.';
  Status := 'waiting';
end;

procedure TMainForm.ClearButtonClick(Sender: TObject);
var
  AudioSize, i: Cardinal;
  Buf: Byte;
begin
  if Status<>'waiting' then Exit;
  Status := 'editing';
  SaveUndoInfo;
  with AudioData do
    AudioSize := Data.Size div nBlockAlign;
  with Selection do
  begin
    if not StartExists or not FinishExists then
    begin
      DeleteMarkers;
      Start := 0;
      Finish := AudioSize-1;
    end;
    Buf := 0;
    AudioData.Data.Position := Start*AudioData.nBlockAlign;
    for i := Start*AudioData.nBlockAlign to Finish*AudioData.nBlockAlign-1 do
      AudioData.Data.Write(Buf, 1);
  end;
  Status := 'waiting';
end;

procedure TMainForm.PasteButtonClick(Sender: TObject);
var
  MP3: TMP3File;
  PCM: TPCMFile;
  EM1: TEM1File;
  i: Byte;
  FileName, S, Ext: String;
  TempAudio: TAudioData;
begin
  if (Status<>'waiting')and(Status<>'starting') then Exit;
  if Sender = PasteFileButton then
  begin
    if OpenDialog.Execute then FileName := OpenDialog.FileName else Exit;
    Status := 'opening';
    Ext := ExtractFileExt(FileName);
    if GetFileAttributes(PChar(FileName)) and FILE_ATTRIBUTE_READONLY = FILE_ATTRIBUTE_READONLY then
      SetFileAttributes(PChar(FileName), GetFileAttributes(PChar(FileName)) xor FILE_ATTRIBUTE_READONLY);
    TempAudio := TAudioData.Create;
    for i := 1 to Length(Ext) do Ext[i] := UpCase(Ext[i]);
    if Ext = '.WAV' then
    begin
      PCM := TPCMFile.Open(FileName);
      PCM.ReadAudioData(TempAudio);
      PCM.Destroy;
    end;
    if Ext = '.MP3' then
    begin
      MP3 := TMP3File.Open(FileName);
      MP3.ReadAudioData(TempAudio);
      MP3.Destroy;
    end;
    if Ext = '.EM1' then
    begin
      EM1 := TEM1File.Open(FileName);
      EM1.ReadAudioData(TempAudio);
      EM1.Destroy;
    end;
    SetnSamplesPerSec(TempAudio, AudioData.nSamplesPerSec);
    SetnBitsPerSample(TempAudio, AudioData.nBitsPerSample);
    SetnChannels(TempAudio, AudioData.nChannels);
  end
  else
  begin
    SetnSamplesPerSec(AudioClipBoard, AudioData.nSamplesPerSec);
    SetnBitsPerSample(AudioClipBoard, AudioData.nBitsPerSample);
    SetnChannels(AudioClipBoard, AudioData.nChannels);
  end;
  Status := 'editing';
  SaveUndoInfo;
  if Sender <> PasteFileButton then
    Case PasteModeComboBox.ItemIndex  of
      0: InsertAudio(AudioClipBoard, AudioData, AudioPosition);
      1: OverWriteAudio(AudioClipBoard, AudioData, AudioPosition);
      2: MixAudio(AudioClipBoard, AudioData, AudioPosition);
    end
  else
    Case PasteModeComboBox.ItemIndex  of
      0: InsertAudio(TempAudio, AudioData, AudioPosition);
      1: OverWriteAudio(TempAudio, AudioData, AudioPosition);
      2: MixAudio(TempAudio, AudioData, AudioPosition);
    end;
  DeleteMarkers;
  SetAudioPosition;
  SetMarker;
  if Sender <> PasteFileButton then
    AudioPosition := AudioPosition + AudioClipBoard.Data.Size div AudioData.nBlockAlign - 1
  else
  begin
    AudioPosition := AudioPosition + TempAudio.Data.Size div AudioData.nBlockAlign - 1;
    TempAudio.Destroy;
  end;
  SetAudioPosition;
  SetMarker;
  Status := 'waiting';
end;

procedure TMainForm.PasteSilenceButtonClick(Sender: TObject);
var
  i: Cardinal;
  b: Byte;
  TempAudio: TAudioData;
begin
  if (Status<>'waiting')and(Status<>'starting') then Exit;
  Status := 'editing';
  SaveUndoInfo;
  TempAudio := TAudioData.Create;
  TempAudio.nChannels := AudioData.nChannels;
  TempAudio.nSamplesPerSec := AudioData.nSamplesPerSec;
  TempAudio.nBitsPerSample := AudioData.nBitsPerSample;
  TempAudio.Calculate_nBlockAlign;
  b := 0;
  for i := 1 to TempAudio.nSamplesPerSec*SilenceTime.Value*TempAudio.nBlockAlign do
    TempAudio.Data.Write(b, 1);
  InsertAudio(TempAudio, AudioData, AudioPosition);
  DeleteMarkers;
  SetAudioPosition;
  SetMarker;
  AudioPosition := AudioPosition + TempAudio.Data.Size div AudioData.nBlockAlign - 1;
  SetAudioPosition;
  SetMarker;
  TempAudio.Destroy;
  Status := 'waiting';
end;

procedure TMainForm.ReverseButtonClick(Sender: TObject);
var
  AudioSize: Cardinal;
begin
  if Status<>'waiting' then Exit;
  Status := 'deformation';
  SaveUndoInfo;
  with AudioData do
    AudioSize := Data.Size div nBlockAlign;
  with Selection do
  begin
    if not StartExists or not FinishExists then
    begin
      DeleteMarkers;
      Start := 0;
      Finish := AudioSize-1;
    end;
    ReverseAudio(AudioData, Start, Finish-Start+1);
  end;
  Status := 'waiting';
end;

procedure TMainForm.NormalizeButtonClick(Sender: TObject);
var
  AudioSize: Cardinal;
begin
  if Status<>'waiting' then Exit;
  Status := 'deformation';
  with AudioData do
    AudioSize := Data.Size div nBlockAlign;
  with Selection do
  begin
    if not StartExists or not FinishExists then
    begin
      DeleteMarkers;
      Start := 0;
      Finish := AudioSize-1;
    end;
    Normalize(AudioData, Start, Finish-Start+1);
  end;
  Status := 'waiting';
  PaintBox1.Repaint;
end;

procedure TMainForm.SetSpeedButtonClick(Sender: TObject);
var
  AudioSize: Cardinal;
begin
  if Status<>'waiting' then Exit;
  Status := 'deformation';
  with AudioData do
    AudioSize := Data.Size div nBlockAlign;
  with Selection do
  begin
    if not StartExists or not FinishExists then
    begin
      DeleteMarkers;
      Start := 0;
      Finish := AudioSize-1;
    end;
    SetSpeedOfAudio(AudioData, Start, Finish-Start+1, SpeedEdit.Value/100);
    DeleteMarkers;
    AudioPosition := Start;
    SetMarker;
    AudioPosition := Trunc(Start+(Finish-Start)*100/SpeedEdit.Value);
    SetMarker;
    AudioPosition := Start;
    SetAudioPosition;
  end;
  Status := 'waiting';
end;

procedure TMainForm.ChangePropertie(Sender: TObject);
var
  S: String;
  Value, Code: Cardinal;
begin
  if (Status<>'waiting')and(Status<>'starting') then Exit;
  Status := 'editing';
  if Sender = nSamplesPerSecButton then
  begin
    Val(nSamplesBox.Text, Value, Code);
    SetnSamplesPerSec(AudioData, Value);
  end;
  if Sender = nBitsPerSampleButton then
  begin
    Val(nBitsBox.Text, Value, Code);
    SetnBitsPerSample(AudioData, Value);
  end;
  if Sender = nChannelsButton then
  begin
    SetnChannels(AudioData, nChannelsBox.ItemIndex+1);
  end;
  AudioData.Calculate_nBlockAlign;
  DeleteMarkers;
  AudioPosition := 0;
  SetAudioPosition;
  Str(AudioData.nChannels, S);
  nChannelsText.Caption := S + ' channels';
  Str(AudioData.nBitsPerSample, S);
  nBitsPerSampleText.Caption := S + ' bits';
  Str(AudioData.nSamplesPerSec, S);
  nSamplesPerSecText.Caption := S + ' Hz';
  Status := 'waiting';
end;

procedure TMainForm.SetVolumeButtonClick(Sender: TObject);
var
  AudioSize: Cardinal;
begin
  if Status<>'waiting' then Exit;
  Status := 'deformation';
  with AudioData do
    AudioSize := Data.Size div nBlockAlign;
  with Selection do
  begin
    if not StartExists or not FinishExists then
    begin
      DeleteMarkers;
      Start := 0;
      Finish := AudioSize-1;
    end;
  SetVolumeOfAudio(AudioData, Start, Finish-Start+1, VolumeEdit.Value/100);
  end;
  Status := 'waiting';
end;

procedure TMainForm.AboutButtonClick(Sender: TObject);
begin
  MessageBox(MainForm.Handle, 'АудиоДеформатор v03.2004'#13#13'Copyright (c) Andre512, 2003-2004'#13#13'http://Andrei512.narod.ru'#13#13'Andrei512@narod.ru', 'About', MB_OK);
end;

procedure TMainForm.HomePageLinkClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar('http://Andrei512.narod.ru'), '', '', SW_Show);
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  AudioData.Destroy;
  AudioClipBoard.Destroy;
  UndoInfo.AudioData.Destroy;
end;

procedure TMainForm.SetSpeedBitBtnClick(Sender: TObject);
var
  AudioSize: Cardinal;
begin
  if Status<>'waiting' then Exit;
  Status := 'deformation';
  SaveUndoInfo;
  with AudioData do
    AudioSize := Data.Size div nBlockAlign;
  with Selection do
  begin
    if not StartExists or not FinishExists then
    begin
      DeleteMarkers;
      Start := 0;
      Finish := AudioSize-1;
    end;
    SetSpeedOfAudio(AudioData, Start, Finish-Start+1, SpeedEdit.Value/100);
    DeleteMarkers;
    AudioPosition := Start;
    SetMarker;
    AudioPosition := Trunc(Start+(Finish-Start)*100/SpeedEdit.Value);
    SetMarker;
    AudioPosition := Start;
    SetAudioPosition;
  end;
  Status := 'waiting';
end;

procedure TMainForm.ChangeSpeedButtonClick(Sender: TObject);
var
  AudioSize, NewCount: Cardinal;
begin
  if Status<>'waiting' then Exit;
  Status := 'deformation';
  SaveUndoInfo;
  with AudioData do
    AudioSize := Data.Size div nBlockAlign;
  with Selection do
  begin
    if not StartExists or not FinishExists then
    begin
      DeleteMarkers;
      Start := 0;
      Finish := AudioSize-1;
    end;
    NewCount := ChangeSpeedOfAudio(AudioData, Start, Finish-Start+1, SpeedEdit.Value/100);
    DeleteMarkers;
    AudioPosition := Start;
    SetMarker;
    AudioPosition := Start+NewCount;
    SetMarker;
    AudioPosition := Start;
    SetAudioPosition;
  end;
  Status := 'waiting';
end;

procedure TMainForm.SetVolumeBitBtnClick(Sender: TObject);
var
  AudioSize: Cardinal;
begin
  if Status<>'waiting' then Exit;
  Status := 'deformation';
  SaveUndoInfo;
  with AudioData do
    AudioSize := Data.Size div nBlockAlign;
  with Selection do
  begin
    if not StartExists or not FinishExists then
    begin
      DeleteMarkers;
      Start := 0;
      Finish := AudioSize-1;
    end;
    SetVolumeOfAudio(AudioData, Start, Finish-Start+1, VolumeEdit.Value/100);
  end;
  Status := 'waiting';
  PaintBox1.Repaint;
end;

procedure TMainForm.ChangeVolumeBitBtnClick(Sender: TObject);
var
  AudioSize: Cardinal;
begin
  if Status<>'waiting' then Exit;
  Status := 'deformation';
  SaveUndoInfo;
  with AudioData do
    AudioSize := Data.Size div nBlockAlign;
  with Selection do
  begin
    if not StartExists or not FinishExists then
    begin
      DeleteMarkers;
      Start := 0;
      Finish := AudioSize-1;
    end;
    ChangeVolumeOfAudio(AudioData, Start, Finish-Start+1, VolumeEdit.Value/100);
  end;
  Status := 'waiting';
  PaintBox1.Repaint;
end;

procedure TMainForm.NormalizeBitBtnClick(Sender: TObject);
var
  AudioSize: Cardinal;
begin
  if Status<>'waiting' then Exit;
  Status := 'deformation';
  SaveUndoInfo;
  with AudioData do
    AudioSize := Data.Size div nBlockAlign;
  with Selection do
  begin
    if not StartExists or not FinishExists then
    begin
      DeleteMarkers;
      Start := 0;
      Finish := AudioSize-1;
    end;
    Normalize(AudioData, Start, Finish-Start+1);
  end;
  Status := 'waiting';
end;

procedure TMainForm.EffectButtonClick(Sender: TObject);
var
  AudioSize: Cardinal;
begin
  if Status<>'waiting' then Exit;
  Status := 'deformation';
  SaveUndoInfo;
  with AudioData do
    AudioSize := Data.Size div nBlockAlign;
  with Selection do
  begin
    if not StartExists or not FinishExists then
    begin
      DeleteMarkers;
      Start := 0;
      Finish := AudioSize-1;
    end;
    case EffectBox.ItemIndex of
      0: ChangeVolumeOfAudio(AudioData, Start, Finish-Start+1, 0);
      1: ReChangeVolumeOfAudio(AudioData, Start, Finish-Start+1, 1);
      2: Echo(AudioData, Start, Finish-Start+1, nResponsesEdit.Value, ResponseTimeEdit.Value, ResponseVolumeEdit.Value/100);
      3: Reverberation(AudioData, Start, Finish-Start+1, nEchosEdit.Value, DelayEdit.Value, EchoVolumeEdit.Value/100);
    end;
  end;
  Status := 'waiting';
  PaintBox1.Repaint;
end;

procedure TMainForm.PaintAudioGraph;
var
  PaintPos, MaxPaintPos: Cardinal;
  AudioPos, SamplesPerPoint, LeftSamples, MaxAmplitude: Cardinal;
  numChannels, Channel, i: Word;
  Smp, Smp1: Integer;
begin
  with PaintBox1.Canvas do
  begin
    Pen.Color := clBlack;
    MoveTo(0, Round(PaintBox1.Height/2));
    LineTo(PaintBox1.Width, Round(PaintBox1.Height/2));
    Pen.Color := clNavy;
  end;
  MaxPaintPos := PaintBox1.Width;
  SamplesPerPoint := 8;
  if AudioPosition-PaintBox1.Width*SamplesPerPoint >= 0 then
  begin
    AudioPos := AudioPosition-PaintBox1.Width*SamplesPerPoint;
    PaintPos := 0;
  end
  else
  begin
    AudioPos := 0;
    PaintPos := PaintBox1.Width - Trunc(AudioPosition/SamplesPerPoint);
  end;
  numChannels := AudioData.nChannels;
  MaxAmplitude := 1;
  for i := 1 to AudioData.nBitsPerSample do
    MaxAmplitude := MaxAmplitude*2;
  Smp := 0;
  for Channel := 0 to numChannels-1 do
  begin
    AudioData.ReadSample(AudioPos, Channel, Smp1);
    Smp := Smp + Smp1;
  end;
  Smp := Round(Smp/numChannels);
  PaintBox1.Canvas.MoveTo(PaintPos, Round(PaintBox1.Height/2-Smp/MaxAmplitude*PaintBox1.Height));
  LeftSamples := SamplesPerPoint;
  while PaintPos<=MaxPaintPos do
  begin
    Smp := 0;
    for Channel := 0 to numChannels-1 do
    begin
      AudioData.ReadSample(AudioPos, Channel, Smp1);
      Smp := Smp + Smp1;
    end;
    Smp := Round(Smp/numChannels);
    PaintBox1.Canvas.LineTo(PaintPos, Round(PaintBox1.Height/2-Smp/MaxAmplitude*PaintBox1.Height));
    Inc(AudioPos);
    Dec(LeftSamples);
    if LeftSamples = 0 then
    begin
      Inc(PaintPos);
      LeftSamples := SamplesPerPoint;
    end;
  end;
end;


procedure TMainForm.PaintBox1Paint(Sender: TObject);
begin
  PaintAudioGraph;
end;

procedure TMainForm.WaveOutButtonClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar('sndvol32.exe'), '', '', SW_Show);
end;

procedure TMainForm.WaveInButtonClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar('sndvol32.exe'),  PChar('/r'), '', SW_Show);
end;

procedure TMainForm.CopyToFileButtonClick(Sender: TObject);
var
  FileName, Ext, EncMode, StereoMode, BitRate: String;
  i: Byte;
  TempAudio: TAudioData;
  Code: Integer;
  PCM: TPCMFile;
  MP3: TMP3File;
  EM1: TEM1File;
  AudioSize: Cardinal;
begin
  if Status<>'waiting' then Exit;
  if SaveDialog.Execute then
    FileName := SaveDialog.FileName else Exit;
  Ext := ExtractFileExt(FileName);
  with AudioData do
    AudioSize := Data.Size div nBlockAlign;
  TempAudio := TAudioData.Create;
  with Selection do
  begin
    if not StartExists or not FinishExists then
    begin
      DeleteMarkers;
      Start := 0;
      Finish := AudioSize-1;
    end;
    CopyAudio(AudioData, TempAudio, Start, Finish);
  end;
  for i := 1 to Length(Ext) do Ext[i] := UpCase(Ext[i]);
  if Ext = '.WAV' then
  begin
    PCM := TPCMFile.Create(FileName, TempAudio);
    PCM.Destroy;
  end;
  if Ext = '.MP3' then
  begin
    if RadioButton1.Checked then
    begin
      BitRate := ConstantBitRateComboBox.Text;
      EncMode := '-b';
    end;
    if RadioButton2.Checked then
    begin
      BitRate := AverageBitRateComboBox.Text;
      EncMode := '--abr';
    end;
    if RadioButton3.Checked then
    begin
      Str(VariableBitrateComboBox.ItemIndex, BitRate);
      EncMode := '-V';
    end;
    case StereoModeComboBox.ItemIndex of
      0: StereoMode := 's';
      1: StereoMode := 'j';
      2: StereoMode := 'f';
      3: StereoMode := 'd';
      4: StereoMode := 'm';
    end;
    MP3 := TMP3File.Create(FileName, TempAudio, BitRate, EncMode, StereoMode);
    MP3.Destroy;
  end;
  if Ext = '.EM1' then
  begin
    EM1 := TEM1File.Create(FileName, TempAudio);
    EM1.Destroy;
  end;
  TempAudio.Destroy;
end;

procedure TMainForm.SaveUndoInfo;
begin
  if not UndoCheckBox.Checked then Exit; 
  UndoInfo.AudioPosition := AudioPosition;
  UndoInfo.Selection.Start := Selection.Start;
  UndoInfo.Selection.Finish := Selection.Finish;
  UndoInfo.Selection.StartExists := Selection.StartExists;
  UndoInfo.Selection.FinishExists := Selection.FinishExists;
  UndoInfo.AudioData.Data.Clear;
  CopyAudio(AudioData, UndoInfo.AudioData, 0, AudioData.Data.Size div AudioData.nBlockAlign - 1);
end;

procedure TMainForm.UndoButtonClick(Sender: TObject);
begin
  if Status<>'waiting' then Exit;
  if UndoInfo.AudioData.Data.Size = 0 then Exit;
  Status := 'undo';
  DeleteMarkers;
  AudioData.Data.Clear;
  CopyAudio(UndoInfo.AudioData, AudioData, 0, UndoInfo.AudioData.Data.Size div UndoInfo.AudioData.nBlockAlign - 1);
  if UndoInfo.Selection.StartExists then
  begin
    AudioPosition := UndoInfo.Selection.Start;
    SetMarker;
  end;
  if UndoInfo.Selection.FinishExists then
  begin
    AudioPosition := UndoInfo.Selection.Finish;
    SetMarker;
  end;
  AudioPosition := UndoInfo.AudioPosition;
  SetAudioPosition;
  UndoInfo.AudioData.Data.Clear;
  Status := 'waiting';
end;

procedure TMainForm.EMailButtonClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar('mailto:Andrei512@narod.ru'), PChar(''), '', SW_Show);
end;

procedure TMainForm.BrainWaveButtonClick(Sender: TObject);
var
  AudioSize: Cardinal;
begin
  if Status<>'waiting' then Exit;
  Status := 'deformation';
  SaveUndoInfo;
  with AudioData do
    AudioSize := Data.Size div nBlockAlign;
  with Selection do
  begin
    if not StartExists or not FinishExists then
    begin
      DeleteMarkers;
      Start := 0;
      Finish := AudioSize-1;
    end;
    AddBrainWave(AudioData, Start, Finish-Start+1, BWFreqEdit1.Value, BWFreqEdit2.Value);
  end;
  Status := 'waiting';
end;

procedure TMainForm.Left10ButtonClick(Sender: TObject);
var
  AudioSize, Smp10ms: Cardinal;
begin
  if Status<>'waiting' then Exit;
  with AudioData do
    AudioSize := Data.Size div nBlockAlign;
  Smp10ms := Round(AudioData.nSamplesPerSec/100);
  if Sender = Left10Button then
    if AudioPosition < Smp10ms then AudioPosition := 0 else AudioPosition := AudioPosition - Smp10ms
  else
    if AudioPosition + Smp10ms >= AudioSize then AudioPosition := AudioSize - 1  else AudioPosition := AudioPosition + Smp10ms;
  SetAudioPosition;  
end;

procedure TMainForm.SSelButtonClick(Sender: TObject);
var
  AudioSize: Cardinal;
begin
  if Status<>'waiting' then Exit;
  with AudioData do
    AudioSize := Data.Size div nBlockAlign;
  if Sender = SSelButton then
    if Selection.StartExists then AudioPosition := Selection.Start else AudioPosition := 0
  else
    if Selection.FinishExists then AudioPosition := Selection.Finish else AudioPosition := AudioSize - 1;
  SetAudioPosition;  
end;

procedure TMainForm.HelpButtonClick(Sender: TObject);
begin
  HelpForm.Visible := True;
  HelpForm.Show;
end;

procedure TMainForm.UndoCheckBoxClick(Sender: TObject);
begin
  if UndoCheckBox.Checked then
    UndoButton.Enabled := True
  else
  begin
    UndoButton.Enabled := False;
    UndoInfo.AudioData.Data.Clear;
  end;
end;

end.
