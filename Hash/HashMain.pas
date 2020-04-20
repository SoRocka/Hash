unit HashMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  QDialogs, Menus, Grids, UGUITable,UInfo, Dialogs, UAddShow;

type
  TMainForm = class(TForm)
    HashTableView: TStringGrid;
    MainMenu: TMainMenu;
    mniN1: TMenuItem;
    mniN2: TMenuItem;
    N1: TMenuItem;
    NNew: TMenuItem;
    NOpen: TMenuItem;
    NSave: TMenuItem;
    NSaveAs: TMenuItem;
    NClose: TMenuItem;
    N2: TMenuItem;
    NExit: TMenuItem;
    NAdd: TMenuItem;
    NDelete: TMenuItem;
    NClear: TMenuItem;
    NFind: TMenuItem;
    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure NCloseClick(Sender: TObject);
    procedure NOpenClick(Sender: TObject);
    procedure NNewClick(Sender: TObject);
    procedure NSaveClick(Sender: TObject);
    procedure NSaveAsClick(Sender: TObject);
    procedure NDeleteClick(Sender: TObject);
    procedure NClearClick(Sender: TObject);
    procedure NAddClick(Sender: TObject);
    procedure NFindClick(Sender: TObject);
  private
    HashTable:TGuiHashTable;
    procedure MyIdle(sender: TObject; var Done:Boolean);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  HashTable:=TGUIHashTable.Create(HashTableView);
  Application.OnIdle:=MyIdle;
  dlgOpen.InitialDir:=ExtractFilePath(Application.ExeName);
  dlgSave.InitialDir:=dlgOpen.InitialDir;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if HashTable<>nil
    then NClose.Click;
  CanClose:=HashTable = nil;
end;

procedure TMainForm.NCloseClick(Sender: TObject);
var
  CanClose:Boolean;
begin
  Canclose:=True;
  if (HashTable<>nil) and (HashTable.Modified)
    then
      case MessageDlg('Сохранить изменения?', mtConfirmation,[mbYes,mbNo,mbCancel],0) of
        mrNo:;
        mrCancel: CanClose:=False;
        mrYes:
          begin
            NSave.Click;
            CanClose:= not HashTable.Modified;
          end;
      end;
  if CanClose
    then FreeAndNil(HashTable);
end;

procedure TMainForm.MyIdle(sender: TObject; var Done: Boolean);
begin
  Done:=True;
  HashTableView.Visible:=HashTable<>nil;
  NSave.Enabled:=(HashTable<>nil) ;
  NSaveAs.Enabled:=NSave.Enabled;
  NClose.Enabled:=HashTable<>nil;
  NAdd.Enabled:=NClose.Enabled;
  NDelete.Enabled:=(Hashtable<>nil) and (HashTable.Count>0);
  NClear.Enabled:=NDelete.Enabled;
  NFind.Enabled:=NDelete.Enabled;
end;

procedure TMainForm.NOpenClick(Sender: TObject);
begin
  if dlgOpen.Execute
    then
      begin
        if HashTable <> nil
          then NClose.Click;

        if HashTable = nil
          then
            begin
              HashTable:=TGUIHashTable.Create(HashTableView);
              HashTable.LoadFromFile(dlgOpen.FileName);
            end;
      end;
end;

procedure TMainForm.NNewClick(Sender: TObject);
begin
  if HashTable <> nil
    then NClose.Click;

  if HashTable = nil
    then HashTable:=TGUIHashTable.Create(HashTableView);
end;

procedure TMainForm.NSaveClick(Sender: TObject);
begin
  if HashTable.Filename = ''
    then NSaveAs.Click
    else HashTable.SaveToFile(HashTable.FileName);
end;

procedure TMainForm.NSaveAsClick(Sender: TObject);
begin
  dlgSave.FileName:=HashTable.Filename;
  if dlgSave.Execute
    then HashTable.SaveToFile(dlgSave.FileName);
end;

procedure TMainForm.NDeleteClick(Sender: TObject);
var
  key:string;
begin
  key:='';
  if QDialogs.InputQuery('Удаление','Введите номер студ. билета',key)
    then
      if HashTable.Delete(key)
        then ShowMessage('Студент удален')
        else MessageDlg('Студент не найден',mtError,[mbCancel],0)
end;

procedure TMainForm.NClearClick(Sender: TObject);
begin
  case MessageDlg('Вы действительно хотите очистить таблицу?',mtConfirmation,[mbYes,mbNo], 0) of
      mrYes :  HashTable.Clear;
      mrNo:;
   end;
end;

procedure TMainForm.NAddClick(Sender: TObject);
begin
  with TFormAdd.Create(Self) do
    try
      if ShowModal=mrOK then
          if not HashTable.Add(Info)
            then
              begin
                MessageDlg('Студент с таким именем уже присутствует в таблице',mtError,[mbCancel],0);
                Info.Free
              end;
    finally
      Free
    end;
end;

procedure TMainForm.NFindClick(Sender: TObject);
var
  Key:string;
  MyInfo:TInfo;
  FormShow: TFormAdd;
begin
  Key:='';
  if InputQuery('Поиск', 'Введите номер студенческого билета', Key) then
    begin
      if HashTable.Find(Key,MyInfo)
        then
          begin
            FormShow:=TFormAdd.Create(Self);
            with FormShow do
            begin
              Caption:='Найденный студент';
              Edit_FIO.Text:=MyInfo.FIO;
              Edit_StudNumber.Text:=MyInfo.key;
              Edit_Mark.Text:=MyInfo.Mark;
              Edit_FIO.ReadOnly:=True;
              Edit_StudNumber.ReadOnly:=True;
              Edit_Mark.ReadOnly:=True;
              btn_Ok.Visible:=False;
              ShowModal
            end;
            FreeAndNil(FormShow);
          end
        else ShowMessage('Студент не найден');
    end;
end;

end.
