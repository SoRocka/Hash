unit UTable;

interface
uses UList, UInfo, Grids, SysUtils;
const N=101;
type
  TIndex = 0..N-1;
  TCell = TInfoList;
  TTable = array [TIndex] of TCell;
  THashTable = class
  private
    FTable:TTable;
    FCount:Integer;
  protected
    function Hash_F(key:TKey):TIndex;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; virtual;
    function Add(Info:TInfo):Boolean;
    function Find(key:TKey;var Info:TInfo):Boolean;
    function Delete(key:TKey):Boolean;
    function LoadFromFile(FileName:String):Boolean;
    procedure SaveToFile(FileName:string);
    procedure ShowToGrid(SG:TStringGrid);
    property Count:Integer read FCount;
  end;
implementation

{ THashTable }

function THashTable.Add(Info: TInfo): Boolean;
var
  pos: TIndex;
begin
  pos:=Hash_F(Info.Key);
  Result:=FTable[pos].Add(Info);
  if Result
    then Inc(FCount);
end;

procedure THashTable.Clear;
var
  i:Integer;
begin
  if FCount>0
    then
      begin
        for i:=0 to N-1 do FTable[i].Clear;
        FCount:=0;
      end;
end;

constructor THashTable.Create;
var
  i:Integer;
begin
  inherited Create;
  for i:=0 to N-1 do FTable[i]:=TInfoList.Create;
  FCount:=0;
end;

function THashTable.Delete(key: TKey): Boolean;
begin
  Result:=FTable[Hash_F(key)].Delete(Key);
  if Result then Dec(FCount);
end;

destructor THashTable.Destroy;
var
  i:Tindex;
begin
  Clear;
  for i:=0 to N-1 do FTable[i].Destroy;
  inherited Destroy;
end;

function THashTable.Find(key: TKey; var Info: TInfo): Boolean;
begin
  Result:=FTable[Hash_F(key)].Find(key,Info);
end;

function THashTable.Hash_F(key: TKey): TIndex;
begin
  Result:=TInfo.Hash(key) mod N;
end;

function THashTable.LoadFromFile(FileName: String): Boolean;
var
  F:TextFile;
  Info:TInfo;
begin
  Result:=True;
  AssignFile(F,FileName);
  Reset(F);
  Clear;
  while (not Eof(F) and Result) do
  begin
    Info:=TInfo.Create;
    result:=(Info.LoadFromFile(f)and Add(Info));
    if not Result
      then FreeAndNil(Info);
  end;
  CloseFile(F);
end;

procedure THashTable.SaveToFile(FileName: string);
var
  i:Integer;
  F:TextFile;
begin
  AssignFile(F,FileName);
  Rewrite(F);
  if FCount > 0
    then  for i:=0 to N-1 do FTable[i].SaveToFile(F);
  CloseFile(F);
end;

procedure THashTable.ShowToGrid(SG: TStringGrid);
var
  i:Integer; index:TIndex;
begin
  if FCount = 0
    then
      begin
        SG.RowCount:=2;
        SG.Rows[1].Clear;
      end
    else SG.RowCount:=FCount+1;
//  TInfo.ShowTitle(SG.Rows[0]);
  i:=0;
  for index:=0 to N-1 do
    if FTable[index]<>nil
      then
        begin
          FTable[index].PrintToGrids(SG,i);
        end;
end;

end.
