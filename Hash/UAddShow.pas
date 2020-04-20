unit UAddShow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UInfo;

type
  TFormAdd = class(TForm)
    Edit_FIO: TEdit;
    Edit_StudNumber: TEdit;
    Edit_Mark: TEdit;
    lbl_FIO: TLabel;
    lbl_StudNumb: TLabel;
    lbl_Name: TLabel;
    btn_Ok: TButton;
    btn_Cancel: TButton;

    procedure btn_OkClick(Sender: TObject);
    procedure Edit_Change(Sender: TObject);
  private
    FInfo: TInfo;
  public
    property Info:TInfo read FInfo;
  end;

implementation

{$R *.dfm}

procedure TFormAdd.btn_OkClick(Sender: TObject);

begin
  if Trim(Edit_FIO.Text)='' then
  begin
    MessageDlg('Не введен ключ', mtError, [mbOK], 0);
    Edit_FIO.SetFocus;
    Exit;
  end;
  FInfo:=TInfo.Create(Edit_FIO.Text,Edit_StudNumber.Text,Edit_Mark.Text);
  ModalResult:=mrOK;
end;

procedure TFormAdd.Edit_Change(Sender: TObject);
begin
  btn_Ok.Enabled:=(Edit_FIO.Text<>'') and (Edit_StudNumber.Text<>'') and (Edit_Mark.Text <> '')
end;

end.
