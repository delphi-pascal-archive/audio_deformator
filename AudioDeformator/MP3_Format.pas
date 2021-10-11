unit MP3_Format;

interface

uses
  SysUtils, ShellApi, Windows, Classes, AudioFormat, PCM_Format;

type
  TMP3File = class(TAudioFile)
  public
    constructor Open(FileName: string);
    constructor Create(FileName: string; var AudioData: TAudioData; BitRate, EncMode, StereoMode: String);
    procedure ReadAudioData(var AudioData: TAudioData);
  private
    Name: String;  
  end;

implementation

{$R Lame.res}

var
  Res: TResourceStream;
  TempDir: String;
  LameFile: String;
  LameParameters: String;

constructor TMP3File.Open(FileName: string);
begin
  inherited Open(FileName);
  Name := FileName;
end;

constructor TMP3File.Create(FileName: string; var AudioData: TAudioData; BitRate, EncMode, StereoMode: String);
var
  TempWaveFile: String;
  PCM: TPCMFile;
  StartupInfo: TStartupInfo;
  ProcessInformation:  TProcessInformation;
begin
  TempWaveFile := TempDir+'TempWave.wav';
  PCM := TPCMFile.Create(TempWaveFile, AudioData);
  PCM.Destroy;
  LameParameters := LameFile+' -m '+StereoMode+' '+EncMode+' '+BitRate+' "'+TempWaveFile+'" "'+FileName+'"';
  FillChar(StartupInfo, SizeOf(StartupInfo), 0 );
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := SW_HIDE;
  CreateProcess(nil, PChar(LameParameters), nil, nil, False, CREATE_DEFAULT_ERROR_MODE+HIGH_PRIORITY_CLASS, nil, nil, StartupInfo, ProcessInformation);
  WaitForSingleObject(ProcessInformation.hProcess, infinite);
  DeleteFile(PChar(TempWaveFile));
  inherited Open(FileName);
  Name := FileName;
end;

procedure TMP3File.ReadAudioData(var AudioData: TAudioData);
var
  TempWaveFile: String;
  PCM: TPCMFile;
  Result: Word;
  StartupInfo: TStartupInfo;
  ProcessInformation:  TProcessInformation;
begin
  TempWaveFile := TempDir+'TempWave.wav';
  LameParameters := LameFile+' --decode '+'"'+Name+'" "'+TempWaveFile+'"';
  FillChar(StartupInfo, SizeOf(StartupInfo), 0 );
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := SW_HIDE;
  CreateProcess(nil, PChar(LameParameters), nil, nil, False, CREATE_DEFAULT_ERROR_MODE+HIGH_PRIORITY_CLASS, nil, nil, StartupInfo, ProcessInformation);
  WaitForSingleObject(ProcessInformation.hProcess, infinite);
  PCM := TPCMFile.Open(TempWaveFile);
  PCM.ReadAudioData(AudioData);
  PCM.Destroy;
  DeleteFile(PChar(TempWaveFile));
end;

initialization
  TempDir := GetEnvironmentVariable('TEMP')+'\';
  Res := TResourceStream.Create(Hinstance, 'Lame', 'ExeFile');
  LameFile := TempDir+'Lame.exe';
  Res.SaveToFile(LameFile);
  Res.Destroy;

end.
