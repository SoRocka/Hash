unit UInfo;

interface
uses Classes, SysUtils;
type
  TKey = string;
  TInfo = class
  private
    FStudNumber: TKey;
    FFIO: string;
    FMark: string;
  protected
  public
    constructor Create; overload;
    constructor Create(AFIO:TKey; AStudNumber, AMark: string);  overload;
    class procedure ShowTitle(ARow:TStrings);
    class function Hash(AKey:TKey):Integer;
    procedure Show(ARow:TStrings);
    function LoadFromFile(var F:TextFile):Boolean;
    procedure SaveToFile(var F:TextFile);
    function IsEqualKey(Akey: TKey): Boolean;
    property Key:TKey read FStudNumber;
    property FIO:string read FFIO;
    property Mark:string read FMark;
  end;
implementation

{ TInfo }
function GetValue (var str : string; var value:string) : boolean;
var i,len:Integer;
begin
  str:=Trim(str);
  len:=Length(str);
  i:=1;
  if len>0 then
    begin
      while (i<=len) and (str[i]<>#9) do inc(i);
      value:=Trim(Copy(str, 1, i-1));
      Result:=True;
      Delete(str,1,i);
    end
  else
    Result:=False;
end;


constructor TInfo.Create;
begin
  FFIO:='';
  FStudNumber:='';
  FMark:='';
  inherited Create;
end;

constructor TInfo.Create(AFIO: TKey; AStudNumber, AMark: string);
begin
  inherited Create;
  FFIO:=AFIO;
  FStudNumber:=AStudNumber;
  FMark:=AMark;
end;

class function TInfo.Hash(AKey: TKey): Integer;
var
  i:Integer;
begin
  Result:=0;
  for i:=1 to Length(AKey)do
  Result:=Result+Ord(AKey[i]);
end;

function TInfo.IsEqualKey(Akey:TKey): Boolean;
begin
  result:=(Akey=FStudNumber);
end;

function TInfo.LoadFromFile(var F: TextFile): Boolean;
var
  tmp:string;
begin
  if Eof(F)
    then Result:=False
    else
      begin
        readln(F,tmp);
        result:=GetValue(tmp,FFIO) and GetValue(tmp,FStudNumber)
          and GetValue(tmp,FMark) and(FFIO<>'');
      end;
end;

const
  Tab = #9;

procedure TInfo.SaveToFile(var F: TextFile);
begin
  Writeln(f,FFIO+#$9+FStudNumber+#$9+FMark);
end;

procedure TInfo.Show(ARow: TStrings);
begin
  ARow[1]:=FFIO;
  ARow[2]:=FStudNumber;
  ARow[3]:=FMark;
end;

class procedure TInfo.ShowTitle(ARow: TStrings);
begin
  ARow[0]:='№ пп';
  ARow[1]:='ФИО';
  ARow[2]:='Номер студ. билета';
  ARow[3]:='Оценка';
end;

end.
