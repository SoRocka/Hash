unit UList;

interface
uses UInfo,Grids, SysUtils;
type
  TElementPointer = ^TElement;
  TElement = record
    Info:Tinfo;
    Next: TElementPointer;
  end;
  TInfoList = class
  private
    FHead:TElementPointer;
 //   FCount:Integer;
  protected
    function GetNode(key:TKey;var p:TElementPointer):TElementPointer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function Add(Info:TInfo):Boolean;
    function Delete(AKey:TKey):Boolean;
    function Find(Akey:TKey; var Info:TInfo):boolean;
    procedure SaveToFile(var F:TextFile);
    procedure PrintToGrids(SG:TStringGrid;var index:integer);
//    property Count:Integer read FCount;
  end;
implementation

procedure AddNode(var h:TElementPointer; Info:TInfo);
var
  t:TElementPointer;
begin
  New(t);
  t.Info:=Info;
  t.Next:=h;
  h:=t;
end;

procedure DelNode(var h:TElementPointer);
var
  t:TElementPointer;
begin
  t:=h;
  h:=h.Next;
  t.Info.Destroy;
  Dispose(t);
end;
{ TInfoList }


function TInfoList.Add(Info: TInfo): Boolean;
var
  T,p:TElementPointer;
begin
  t:=GetNode(Info.Key,p);
  Result:= t = nil;
  if Result
    then
      if p = nil
        then AddNode(FHead,Info)
        else AddNode(p.Next,Info);
end;

procedure TInfoList.Clear;
begin
  while FHead<>nil do
    DelNode(FHead);
end;

constructor TInfoList.Create;
begin
  inherited Create;
  Fhead:=nil;
end;

function TInfoList.Delete(AKey: TKey): Boolean;
var
  t,p:TElementPointer;
begin
  t:=GetNode(AKey,p);
  Result:=t<>nil;
  if Result
    then
      if p=nil
        then DelNode(FHead)
        else DelNode(p.Next);
end;

destructor TInfoList.Destroy;
begin
  Clear;
  inherited destroy;
end;

function TInfoList.Find(Akey: TKey; var Info: TInfo): boolean;
var
  t,p:TElementPointer;
begin
  t:=GetNode(Akey, p);
  Result := t<>nil;
  if Result
    then Info:=t.Info;
end;

function TInfoList.GetNode(key: TKey;
  var p: TElementPointer): TElementPointer;
var
  ok:Boolean;
begin
  p:=nil;
  Result:=FHead;
  Ok:=False;
  while(Result<>nil) and (not ok) do
  if Result.Info.IsEqualKey(key)
    then Ok:=True
    else
      begin
        p:=Result;
        Result:=Result.Next;
      end;
end;

procedure TInfoList.PrintToGrids(SG: TStringGrid;var index:Integer);
var
  tmp:TElementPointer;
begin
  tmp:=FHead;
  while tmp<>nil do
  begin
    inc(index);
    tmp.Info.Show(SG.Rows[index]);
    SG.Cells[0,index]:=IntToStr(index);
    tmp:=tmp.Next;
  end;
end;

procedure TInfoList.SaveToFile(var F: TextFile);
var
  tmp:TElementPointer;
begin
  tmp:=FHead;
  while tmp <> nil do
  begin
    tmp.Info.SaveToFile(F);
    tmp:=tmp.Next;
  end;
end;

end.
