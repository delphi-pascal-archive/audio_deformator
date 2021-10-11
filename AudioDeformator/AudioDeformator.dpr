program AudioDeformator;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  FileUtils in 'FileUtils.pas',
  AudioFormat in 'AudioFormat.pas',
  MP3_Format in 'MP3_Format.pas',
  EM1_Format in 'EM1_Format.pas',
  Help in 'Help.pas' {HelpForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'АудиоДеформатор';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(THelpForm, HelpForm);
  Application.Run;
end.
