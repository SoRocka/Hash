program Hash;

uses
  Forms,
  HashMain in 'HashMain.pas' {MainForm},
  UList in 'UList.pas',
  UInfo in 'UInfo.pas',
  UTable in 'UTable.pas',
  UGUITable in 'UGUITable.pas',
  UAddShow in 'UAddShow.pas' {FormAdd};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
