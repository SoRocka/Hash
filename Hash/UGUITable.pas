unit UGUITable;

interface
uses UTable,UInfo,Grids;
type
  TGUIHashTable = class(THashTable)
  private
    FModified:Boolean;
    FFileName:string;
    FGrid: TStringGrid;
  protected
    procedure SetModified(value:Boolean);
  public
    constructor Create(SG:TStringGrid);
    procedure Clear; override;
    function Add(Info:TInfo):Boolean;
    function Delete(key:TKey):Boolean;
    function LoadFromFile(FileName:String):Boolean;
    procedure SaveToFile(FileName:string);
    property Modified:Boolean read FModified write SetModified;
    property FileName:String read FFileName;
  end;
implementation

{ TGUIHashTable }

function TGUIHashTable.Add(Info: TInfo): Boolean;
begin
  Result:=inherited Add(Info);
  if Result
    then Modified:=True;
end;

procedure TGUIHashTable.Clear;
begin
  if Count >0
    then
      begin
        inherited Clear;
        Modified:=True;
      end;
end;

constructor TGUIHashTable.Create(SG:TStringGrid);
begin
  inherited Create;
  FModified:=False;
  FFileName:='';
  FGrid:=SG;
  TInfo.ShowTitle(FGrid.Rows[0]);
  ShowToGrid(FGrid);
end;

function TGUIHashTable.Delete(key: TKey): Boolean;
begin
  Result:=inherited Delete(key);
  if Result
    then Modified:=True;
end;

function TGUIHashTable.LoadFromFile(FileName: String): Boolean;
begin
  FFileName:=FileName;
  Result:=inherited LoadFromFile(Filename);
  FModified:=False;
  ShowToGrid(FGrid);
end;

procedure TGUIHashTable.SaveToFile(FileName: string);
begin
  FFileName:=FileName;
  FModified:=false;
  inherited SaveToFile(FFileName);
end;


procedure TGUIHashTable.SetModified(value: Boolean);
begin
  FModified:=value;
  if value
    then ShowToGrid(FGrid);
end;

end.
