///<summary>Abstract syntax tree for the SQL query builder.</summary>
///<author>Primoz Gabrijelcic</author>
///<remarks><para>
///Copyright (c) 2015, Primoz Gabrijelcic
///All rights reserved.
///
///Redistribution and use in source and binary forms, with or without
///modification, are permitted provided that the following conditions are met:
///
///* Redistributions of source code must retain the above copyright notice, this
///  list of conditions and the following disclaimer.
///
///* Redistributions in binary form must reproduce the above copyright notice,
///  this list of conditions and the following disclaimer in the documentation
///  and/or other materials provided with the distribution.
///
///* Neither the name of GpSQLBuilder nor the names of its
///  contributors may be used to endorse or promote products derived from
///  this software without specific prior written permission.
///
///THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
///AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
///IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
///DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
///FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
///DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
///SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
///CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
///OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
///OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
///
///   Author            : Primoz Gabrijelcic
///   Creation date     : 2015-04-20
///   Last modification : 2015-04-29
///   Version           : 1.0
///   History:
///     1.0: 2015-04-29
///       - Released.
///</para></remarks>

unit GpSQLBuilder.AST;

interface

uses
  System.Generics.Collections;

type
  IGpSQLCase = interface;

  IGpSQLName = interface
  ['{B219D388-7E5E-4F71-A1F1-9AE4DDE754BC}']
    function  GetAlias: string;
    function  GetCase: IGpSQLCase;
    function  GetName: string;
    procedure SetAlias(const value: string);
    procedure SetCase(const value: IGpSQLCase);
    procedure SetName(const value: string);
  //
    procedure Clear;
    function  IsEmpty: boolean;
    property Name: string read GetName write SetName;
    property &Case: IGpSQLCase read GetCase write SetCase;
    property Alias: string read GetAlias write SetAlias;
  end; { IGpSQLName }

  IGpSQLColumns = interface
  ['{DA9157F6-3526-4DA4-8CD3-115DFE7719B3}']
    function  GetColumns(idx: integer): IGpSQLName;
  //
    function  Add: IGpSQLName; overload;
    procedure Add(const name: IGpSQLName); overload;
    procedure Clear;
    function  Count: integer;
    function  IsEmpty: boolean;
    property Columns[idx: integer]: IGpSQLName read GetColumns; default;
  end; { IGpSQLColumns }

  TGpSQLExpressionOperation = (opNone, opAnd, opOr);

  IGpSQLExpression = interface ['{011D9FD2-AE54-4720-98AB-085D6F6B421E}']
    function  GetLeft: IGpSQLExpression;
    function  GetOperation: TGpSQLExpressionOperation;
    function  GetRight: IGpSQLExpression;
    function  GetTerm: string;
    procedure SetLeft(const value: IGpSQLExpression);
    procedure SetOperation(const value: TGpSQLExpressionOperation);
    procedure SetRight(const value: IGpSQLExpression);
    procedure SetTerm(const value: string);
  //
    procedure Assign(const node: IGpSQLExpression);
    procedure Clear;
    function  IsEmpty: boolean;
    property Term: string read GetTerm write SetTerm;
    property Operation: TGpSQLExpressionOperation read GetOperation write SetOperation;
    property Left: IGpSQLExpression read GetLeft write SetLeft;
    property Right: IGpSQLExpression read GetRight write SetRight;
  end; { IGpSQLExpression }

  IGpSQLCaseWhenThen = interface ['{ADEF8C82-FDF5-4960-9F77-EC0A57AA082E}']
    function  GetThenExpression: IGpSQLExpression;
    function  GetWhenExpression: IGpSQLExpression;
    procedure SetThenExpression(const value: IGpSQLExpression);
    procedure SetWhenExpression(const value: IGpSQLExpression);
  //
    property WhenExpression: IGpSQLExpression read GetWhenExpression write SetWhenExpression;
    property ThenExpression: IGpSQLExpression read GetThenExpression write SetThenExpression;
  end; { IGpSQLCaseWhenThen }

  IGpSQLCaseWhenList = interface ['{0D18F711-5002-421D-A1CA-8D1D36F4653E}']
    function  GetWhenThen(idx: integer): IGpSQLCaseWhenThen;
    procedure SetWhenThen(idx: integer; const value: IGpSQLCaseWhenThen);
  //
    function  Add: IGpSQLCaseWhenThen; overload;
    function  Add(const whenThen: IGpSQLCaseWhenThen): integer; overload;
    function  Count: integer;
    property WhenThen[idx: integer]: IGpSQLCaseWhenThen read GetWhenThen write SetWhenThen; default;
  end; { IGpSQLCaseWhenList }

  IGpSQLCase = interface ['{F6F45A4A-1108-4BA6-92F5-7A7386E2388C}']
    function  GetCaseExpression: IGpSQLExpression;
    function  GetElseExpression: IGpSQLExpression;
    function  GetWhenList: IGpSQLCaseWhenList;
    procedure SetCaseExpression(const value: IGpSQLExpression);
    procedure SetElseExpression(const value: IGpSQLExpression);
    procedure SetWhenList(const value: IGpSQLCaseWhenList);
  //
    property CaseExpression: IGpSQLExpression read GetCaseExpression write SetCaseExpression;
    property WhenList: IGpSQLCaseWhenList read GetWhenList write SetWhenList;
    property ElseExpression: IGpSQLExpression read GetElseExpression write SetElseExpression;
  end; { IGpSQLCase }

  IGpSQLSection = interface ['{BE0A0FF9-AD70-40C5-A1C2-7FA2F7061153}']
    function  GetName: string;
  //
    procedure Clear;
    function  IsEmpty: boolean;
    property Name: string read GetName;
  end; { IGpSQLSection }

  TGpSQLSelectQualifierType = (sqFirst, sqSkip);

  IGpSQLSelectQualifier = interface ['{EC0EC192-81C6-493B-B4A7-F8DA7F6D0D4B}']
    function  GetQualifier: TGpSQLSelectQualifierType;
    function  GetValue: integer;
    procedure SetQualifier(const value: TGpSQLSelectQualifierType);
    procedure SetValue(const value: integer);
  //
    property Qualifier: TGpSQLSelectQualifierType read GetQualifier write SetQualifier;
    property Value: integer read GetValue write SetValue;
  end; { IGpSQLSelectQualifier }

  IGpSQLSelectQualifiers = interface ['{522F34BC-C916-45B6-9DC2-E800FEC7661A}']
    function GetQualifier(idx: integer): IGpSQLSelectQualifier;
  //
    function  Add: IGpSQLSelectQualifier; overload;
    procedure Add(qualifier: IGpSQLSelectQualifier); overload;
    procedure Clear;
    function  Count: integer;
    function  IsEmpty: boolean;
    property Qualifier[idx: integer]: IGpSQLSelectQualifier read GetQualifier; default;
  end; { IGpSQLSelectQualifiers }

  IGpSQLSelect = interface(IGpSQLSection) ['{6B23B86E-97F3-4D8A-BED5-A678EAEF7842}']
    function  GetColumns: IGpSQLColumns;
    function  GetQualifiers: IGpSQLSelectQualifiers;
    function  GetTableName: IGpSQLName;
    procedure SetTableName(const value: IGpSQLName);
  //
    property Columns: IGpSQLColumns read GetColumns;
    property Qualifiers: IGpSQLSelectQualifiers read GetQualifiers;
    property TableName: IGpSQLName read GetTableName write SetTableName;
  end; { IGpSQLSelect }

  TGpSQLJoinType = (jtInner, jtLeft, jtRight, jtFull);

  IGpSQLJoin = interface(IGpSQLSection) ['{CD8AD84D-2FCC-4EBD-A83A-A637CF9D188E}']
    function  GetCondition: IGpSQLExpression;
    function  GetJoinedTable: IGpSQLName;
    function  GetJoinType: TGpSQLJoinType;
    procedure SetCondition(const value: IGpSQLExpression);
    procedure SetJoinedTable(const value: IGpSQLName);
    procedure SetJoinType(const value: TGpSQLJoinType);
  //
    property JoinedTable: IGpSQLName read GetJoinedTable write SetJoinedTable;
    property JoinType: TGpSQLJoinType read GetJoinType write SetJoinType;
    property Condition: IGpSQLExpression read GetCondition write SetCondition;
  end; { IGpSQLJoin }

  IGpSQLJoins = interface ['{5C277003-FC57-4DE5-B041-371012A51D82}']
    function  GetJoins(idx: integer): IGpSQLJoin;
    procedure SetJoins(idx: integer; const value: IGpSQLJoin);
  //
    function  Add: IGpSQLJoin; overload;
    procedure Add(const join: IGpSQLJoin); overload;
    procedure Clear;
    function  Count: integer;
    function  IsEmpty: boolean;
    property Joins[idx: integer]: IGpSQLJoin read GetJoins write SetJoins; default;
  end; { IGpSQLJoins }

  IGpSQLWhere = interface(IGpSQLSection) ['{77BD3E41-53DC-4FC7-B0ED-B339564791AA}']
    function  GetExpression: IGpSQLExpression;
    procedure SetExpression(const value: IGpSQLExpression);
  //
    property Expression: IGpSQLExpression read GetExpression write SetExpression;
  end; { IGpSQLWhere }

  IGpSQLGroupBy = interface(IGpSQLSection) ['{B8B50CF2-2E2A-4C3C-B9B6-D6B0BE92502C}']
    function GetColumns: IGpSQLColumns;
  //
    property Columns: IGpSQLColumns read GetColumns;
  end; { IGpSQLGroupBy }

  IGpSQLHaving = interface(IGpSQLSection) ['{BF1459A7-C665-4983-A724-A7002F6D201F}']
    function  GetExpression: IGpSQLExpression;
    procedure SetExpression(const value: IGpSQLExpression);
  //
    property Expression: IGpSQLExpression read GetExpression write SetExpression;
  end; { IGpSQLHaving }

  TGpSQLOrderByDirection = (dirAscending, dirDescending);

  IGpSQLOrderByColumn = interface(IGpSQLName) ['{05ECC702-D102-4D7D-A150-49A7A8787A7C}']
    function  GetDirection: TGpSQLOrderByDirection;
    procedure SetDirection(const value: TGpSQLOrderByDirection);
  //
    property Direction: TGpSQLOrderByDirection read GetDirection write SetDirection;
  end; { IGpSQLOrderByColumn }

  IGpSQLOrderBy = interface(IGpSQLSection) ['{6BC985B7-219A-4359-9F21-60A985969368}']
    function GetColumns: IGpSQLColumns;
  //
    property Columns: IGpSQLColumns read GetColumns;
  end; { IGpSQLOrderBy }

  IGpSQLAST = interface
    function GetGroupBy: IGpSQLGroupBy;
    function GetHaving: IGpSQLHaving;
    function GetJoins: IGpSQLJoins;
    function GetOrderBy: IGpSQLOrderBy;
    function GetSelect: IGpSQLSelect;
    function GetWhere: IGpSQLWhere;
  //
    procedure Clear;
    function  IsEmpty: boolean;
    property Select: IGpSQLSelect read GetSelect;
    property Joins: IGpSQLJoins read GetJoins;
    property Where: IGpSQLWhere read GetWhere;
    property GroupBy: IGpSQLGroupBy read GetGroupBy;
    property Having: IGpSQLHaving read GetHaving;
    property OrderBy: IGpSQLOrderBy read GetOrderBy;
  end; { IGpSQLAST }

  function CreateSQLAST: IGpSQLAST;
  function CreateSQLExpression: IGpSQLExpression;
  function CreateSQLCase: IGpSQLCase;

implementation

uses
  System.SysUtils;

type
  TGpSQLName = class(TInterfacedObject, IGpSQLName)
  strict private
    FAlias: string;
    FCase : IGpSQLCase;
    FName : string;
  strict protected
    function  GetAlias: string;
    function  GetCase: IGpSQLCase;
    function  GetName: string;
    procedure SetAlias(const value: string);
    procedure SetCase(const value: IGpSQLCase);
    procedure SetName(const value: string);
  public
    procedure Clear;
    function  IsEmpty: boolean;
    property Name: string read GetName write SetName;
    property &Case: IGpSQLCase read GetCase write SetCase;
    property Alias: string read GetAlias write SetAlias;
  end; { TGpSQLName }

  TGpSQLColumns = class(TInterfacedObject, IGpSQLColumns)
  strict private
    FColumns: TList<IGpSQLName>;
  strict protected
    function  GetColumns(idx: integer): IGpSQLName;
  public
    constructor Create;
    destructor  Destroy; override;
    function  Add: IGpSQLName; overload; virtual;
    procedure Add(const name: IGpSQLName); overload; virtual;
    procedure Clear;
    function  Count: integer;
    function  IsEmpty: boolean;
    property Columns[idx: integer]: IGpSQLName read GetColumns; default;
  end; { TGpSQLColumns }

  TGpSQLExpression = class(TInterfacedObject, IGpSQLExpression)
  strict private
    FLeft     : IGpSQLExpression;
    FOperation: TGpSQLExpressionOperation;
    FRight    : IGpSQLExpression;
    FTerm     : string;
  strict protected
    function  GetLeft: IGpSQLExpression;
    function  GetOperation: TGpSQLExpressionOperation;
    function  GetRight: IGpSQLExpression;
    function  GetTerm: string;
    procedure SetLeft(const value: IGpSQLExpression);
    procedure SetOperation(const value: TGpSQLExpressionOperation);
    procedure SetRight(const value: IGpSQLExpression);
    procedure SetTerm(const value: string);
  public
    procedure Assign(const node: IGpSQLExpression);
    procedure Clear;
    function  IsEmpty: boolean;
    property Term: string read GetTerm write SetTerm;
    property Operation: TGpSQLExpressionOperation read GetOperation write SetOperation;
    property Left: IGpSQLExpression read GetLeft write SetLeft;
    property Right: IGpSQLExpression read GetRight write SetRight;
  end; { TGpSQLExpression }

  TGpSQLCaseWhenThen = class(TInterfacedObject, IGpSQLCaseWhenThen)
  strict private
    FThenExpression: IGpSQLExpression;
    FWhenExpression: IGpSQLExpression;
  strict protected
    function  GetThenExpression: IGpSQLExpression;
    function  GetWhenExpression: IGpSQLExpression;
    procedure SetThenExpression(const value: IGpSQLExpression);
    procedure SetWhenExpression(const value: IGpSQLExpression);
  public
    constructor Create;
    property WhenExpression: IGpSQLExpression read GetWhenExpression write SetWhenExpression;
    property ThenExpression: IGpSQLExpression read GetThenExpression write SetThenExpression;
  end; { TGpSQLCaseWhenThen }

  TGpSQLCaseWhenList = class(TInterfacedObject, IGpSQLCaseWhenList)
  strict private
    FWhenThenList: TList<IGpSQLCaseWhenThen>;
  strict protected
    function  GetWhenThen(idx: integer): IGpSQLCaseWhenThen;
    procedure SetWhenThen(idx: integer; const value: IGpSQLCaseWhenThen);
  public
    constructor Create;
    destructor  Destroy; override;
    function  Add: IGpSQLCaseWhenThen; overload;
    function  Add(const whenThen: IGpSQLCaseWhenThen): integer; overload;
    function  Count: integer;
    property WhenThen[idx: integer]: IGpSQLCaseWhenThen read GetWhenThen write SetWhenThen; default;
  end; { TGpSQLCaseWhenList }

  TGpSQLCase = class(TInterfacedObject, IGpSQLCase)
  strict private
    FCaseExpression: IGpSQLExpression;
    FElseExpression: IGpSQLExpression;
    FWhenList      : IGpSQLCaseWhenList;
  strict protected
    function  GetCaseExpression: IGpSQLExpression;
    function  GetElseExpression: IGpSQLExpression;
    function  GetWhenList: IGpSQLCaseWhenList;
    procedure SetCaseExpression(const value: IGpSQLExpression);
    procedure SetElseExpression(const value: IGpSQLExpression);
    procedure SetWhenList(const value: IGpSQLCaseWhenList);
  public
    constructor Create;
    property CaseExpression: IGpSQLExpression read GetCaseExpression write SetCaseExpression;
    property WhenList: IGpSQLCaseWhenList read GetWhenList write SetWhenList;
    property ElseExpression: IGpSQLExpression read GetElseExpression write SetElseExpression;
  end; { TGpSQLCase }

  TGpSQLSection = class(TInterfacedObject, IGpSQLSection)
  strict private
    FName: string;
  strict protected
    function  GetName: string;
  public
    constructor Create(sectionName: string);
    procedure Clear; virtual; abstract;
    function  IsEmpty: boolean; virtual; abstract;
    property Name: string read GetName;
  end; { TGpSQLSection }

  TGpSQLSelectQualifier = class(TInterfacedObject, IGpSQLSelectQualifier)
  strict private
    FQualifier: TGpSQLSelectQualifierType;
    FValue    : integer;
  strict protected
    function  GetQualifier: TGpSQLSelectQualifierType;
    function  GetValue: integer;
    procedure SetQualifier(const value: TGpSQLSelectQualifierType);
    procedure SetValue(const value: integer);
  public
    property Qualifier: TGpSQLSelectQualifierType read GetQualifier write SetQualifier;
    property Value: integer read GetValue write SetValue;
  end; { TGpSQLSelectQualifier }

  TGpSQLSelectQualifiers = class(TInterfacedObject, IGpSQLSelectQualifiers)
  strict private
    FQualifiers: TList<IGpSQLSelectQualifier>;
  strict protected
    function  GetQualifier(idx: integer): IGpSQLSelectQualifier;
  public
    constructor Create;
    destructor  Destroy; override;
    function  Add: IGpSQLSelectQualifier; overload;
    procedure Add(qualifier: IGpSQLSelectQualifier); overload;
    procedure Clear;
    function  Count: integer;
    function  IsEmpty: boolean;
    property Qualifier[idx: integer]: IGpSQLSelectQualifier read GetQualifier; default;
  end; { TGpSQLSelectQualifiers }

  TGpSQLSelect = class(TGpSQLSection, IGpSQLSelect)
  strict private
    FColumns   : IGpSQLColumns;
    FQualifiers: IGpSQLSelectQualifiers;
    FTableName : IGpSQLName;
  strict protected
    function  GetColumns: IGpSQLColumns;
    function  GetQualifiers: IGpSQLSelectQualifiers;
    function  GetTableName: IGpSQLName;
    procedure SetTableName(const value: IGpSQLName);
  public
    constructor Create;
    procedure Clear; override;
    function  IsEmpty: boolean; override;
    property Columns: IGpSQLColumns read GetColumns;
    property Qualifiers: IGpSQLSelectQualifiers read GetQualifiers;
    property TableName: IGpSQLName read GetTableName write SetTableName;
  end; { IGpSQLSelect }

  TGpSQLJoin = class(TGpSQLSection, IGpSQLJoin)
  strict private
    FCondition  : IGpSQLExpression;
    FJoinedTable: IGpSQLName;
    FJoinType   : TGpSQLJoinType;
  strict protected
    function  GetCondition: IGpSQLExpression;
    function  GetJoinedTable: IGpSQLName;
    function  GetJoinType: TGpSQLJoinType;
    procedure SetCondition(const value: IGpSQLExpression);
    procedure SetJoinedTable(const value: IGpSQLName);
    procedure SetJoinType(const value: TGpSQLJoinType);
  public
    constructor Create;
    procedure Clear; override;
    function  IsEmpty: boolean; override;
    property Condition: IGpSQLExpression read GetCondition write SetCondition;
    property JoinedTable: IGpSQLName read GetJoinedTable write SetJoinedTable;
    property JoinType: TGpSQLJoinType read GetJoinType write SetJoinType;
  end; { TGpSQLJoin }

  TGpSQLJoins = class(TInterfacedObject, IGpSQLJoins)
  strict private
    FJoins: TList<IGpSQLJoin>;
  strict protected
    function  GetJoins(idx: integer): IGpSQLJoin;
    procedure SetJoins(idx: integer; const value: IGpSQLJoin);
  public
    constructor Create;
    destructor  Destroy; override;
    function  Add: IGpSQLJoin; overload;
    procedure Add(const join: IGpSQLJoin); overload;
    procedure Clear;
    function  Count: integer;
    function  IsEmpty: boolean;
    property Joins[idx: integer]: IGpSQLJoin read GetJoins write SetJoins; default;
  end; { TGpSQLJoins }

  TGpSQLWhere = class(TGpSQLSection, IGpSQLWhere)
  strict private
    FExpression: IGpSQLExpression;
  strict protected
    function  GetExpression: IGpSQLExpression;
    procedure SetExpression(const value: IGpSQLExpression);
  public
    constructor Create;
    procedure Clear; override;
    function  IsEmpty: boolean; override;
    property Expression: IGpSQLExpression read GetExpression write SetExpression;
  end; { TGpSQLWhere }

  TGpSQLGroupBy = class(TGpSQLSection, IGpSQLGroupBy)
  strict private
    FColumns: IGpSQLColumns;
  strict protected
    function  GetColumns: IGpSQLColumns;
  public
    constructor Create;
    procedure Clear; override;
    function  IsEmpty: boolean; override;
    property Columns: IGpSQLColumns read GetColumns;
  end; { IGpSQLGroupBy }

  TGpSQLHaving = class(TGpSQLSection, IGpSQLHaving)
  strict private
    FExpression: IGpSQLExpression;
  strict protected
    function  GetExpression: IGpSQLExpression;
    procedure SetExpression(const value: IGpSQLExpression);
  public
    constructor Create;
    procedure Clear; override;
    function  IsEmpty: boolean; override;
    property Expression: IGpSQLExpression read GetExpression write SetExpression;
  end; { TGpSQLHaving }

  TGpSQLOrderByColumn = class(TGpSQLName, IGpSQLOrderByColumn)
  strict private
    FDirection: TGpSQLOrderByDirection;
  strict protected
    function  GetDirection: TGpSQLOrderByDirection;
    procedure SetDirection(const value: TGpSQLOrderByDirection);
  public
    property Direction: TGpSQLOrderByDirection read GetDirection write SetDirection;
  end; { TGpSQLOrderByColumn }

  TGpSQLOrderByColumns = class(TGpSQLColumns)
  public
    function Add: IGpSQLName; override;
  end; { TGpSQLOrderByColumns }

  TGpSQLOrderBy = class(TGpSQLSection, IGpSQLOrderBy)
  strict private
    FColumns: IGpSQLColumns;
  strict protected
    function  GetColumns: IGpSQLColumns;
  public
    constructor Create;
    procedure Clear; override;
    function  IsEmpty: boolean; override;
    property Columns: IGpSQLColumns read GetColumns;
  end; { IGpSQLOrderBy }

  TGpSQLAST = class(TInterfacedObject, IGpSQLAST)
  strict private
    FGroupBy: IGpSQLGroupBy;
    FHaving : IGpSQLHaving;
    FJoins  : IGpSQLJoins;
    FOrderBy: IGpSQLOrderBy;
    FSelect : IGpSQLSelect;
    FWhere  : IGpSQLWhere;
  strict protected
    function GetGroupBy: IGpSQLGroupBy;
    function GetHaving: IGpSQLHaving;
    function GetJoins: IGpSQLJoins;
    function GetOrderBy: IGpSQLOrderBy;
    function GetSelect: IGpSQLSelect;
    function GetWhere: IGpSQLWhere;
  public
    constructor Create;
    procedure Clear;
    function  IsEmpty: boolean;
    property Select: IGpSQLSelect read GetSelect;
    property Joins: IGpSQLJoins read GetJoins;
    property Where: IGpSQLWhere read GetWhere;
    property GroupBy: IGpSQLGroupBy read GetGroupBy;
    property Having: IGpSQLHaving read GetHaving;
    property OrderBy: IGpSQLOrderBy read GetOrderBy;
  end; { TGpSQLAST }

{ exports }

function CreateSQLAST: IGpSQLAST;
begin
  Result := TGpSQLAST.Create;
end; { CreateSQLAST }

function CreateSQLExpression: IGpSQLExpression;
begin
  Result := TGpSQLExpression.Create;
end; { CreateSQLExpression }

function CreateSQLCase: IGpSQLCase;
begin
  Result := TGpSQLCase.Create;
end; { CreateSQLCase }

{ TGpSQLName }

procedure TGpSQLName.Clear;
begin
  FName := '';
  FAlias := '';
end; { TGpSQLName.Clear }

function TGpSQLName.GetAlias: string;
begin
  Result := FAlias;
end; { TGpSQLName.GetAlias }

function TGpSQLName.GetCase: IGpSQLCase;
begin
  Result := FCase;
end; { TGpSQLName.GetCase }

function TGpSQLName.GetName: string;
begin
  Result := FName;
end; { TGpSQLName.GetName }

function TGpSQLName.IsEmpty: boolean;
begin
  Result := (FName = '') and (FAlias = '');
end; { TGpSQLName.IsEmpty }

procedure TGpSQLName.SetAlias(const value: string);
begin
  FAlias := value;
end; { TGpSQLName.SetAlias }

procedure TGpSQLName.SetCase(const value: IGpSQLCase);
begin
  FCase := value;
end; { TGpSQLName.SetCase }

procedure TGpSQLName.SetName(const value: string);
begin
  FName := value;
end; { TGpSQLName.SetName }

{ TGpSQLColumns }

constructor TGpSQLColumns.Create;
begin
  inherited Create;
  FColumns := TList<IGpSQLName>.Create;
end; { TGpSQLColumns.Create }

destructor TGpSQLColumns.Destroy;
begin
  FreeAndNil(FColumns);
  inherited;
end; { TGpSQLColumns.Destroy }

function TGpSQLColumns.Add: IGpSQLName;
begin
  Result := TGpSQLName.Create;
  Add(Result);
end; { TGpSQLColumns.Add }

procedure TGpSQLColumns.Add(const name: IGpSQLName);
begin
  FColumns.Add(name);
end; { TGpSQLColumns.Add }

procedure TGpSQLColumns.Clear;
begin
  FColumns.Clear;
end; { TGpSQLColumns.Clear }

function TGpSQLColumns.Count: integer;
begin
  Result := FColumns.Count;
end; { TGpSQLColumns.Count }

function TGpSQLColumns.GetColumns(idx: integer): IGpSQLName;
begin
  Result := FColumns[idx];
end; { TGpSQLColumns.GetColumns }

function TGpSQLColumns.IsEmpty: boolean;
begin
  Result := (Count = 0);
end; { TGpSQLColumns.IsEmpty }

{ TGpSQLExpression }

procedure TGpSQLExpression.Assign(const node: IGpSQLExpression);
begin
  FLeft := node.Left;
  FRight := node.Right;
  FTerm := node.Term;
  FOperation := node.Operation;
end; { TGpSQLExpression.Assign }

procedure TGpSQLExpression.Clear;
begin
  FOperation := opNone;
  FTerm := '';
  FLeft := nil;
  FRight := nil;
end; { TGpSQLExpression.Clear }

function TGpSQLExpression.GetLeft: IGpSQLExpression;
begin
  Result := FLeft;
end; { TGpSQLExpression.GetLeft }

function TGpSQLExpression.GetOperation: TGpSQLExpressionOperation;
begin
  Result := FOperation;
end; { TGpSQLExpression.GetOperation }

function TGpSQLExpression.GetRight: IGpSQLExpression;
begin
  Result := FRight;
end; { TGpSQLExpression.GetRight }

function TGpSQLExpression.GetTerm: string;
begin
  Result := FTerm;
end; { TGpSQLExpression.GetTerm }

function TGpSQLExpression.IsEmpty: boolean;
begin
  Result := (FOperation = opNone) and (FTerm = '');
end; { TGpSQLExpression.IsEmpty }

procedure TGpSQLExpression.SetLeft(const value: IGpSQLExpression);
begin
  FLeft := value;
end; { TGpSQLExpression.SetLeft }

procedure TGpSQLExpression.SetOperation(const value: TGpSQLExpressionOperation);
begin
  FOperation := value;
end; { TGpSQLExpression.SetOperation }

procedure TGpSQLExpression.SetRight(const value: IGpSQLExpression);
begin
  FRight := value;
end; { TGpSQLExpression.SetRight }

procedure TGpSQLExpression.SetTerm(const value: string);
begin
  FTerm := value;
end; { TGpSQLExpression.SetTerm }

{ TGpSQLCaseWhenThen }

constructor TGpSQLCaseWhenThen.Create;
begin
  inherited Create;
  FWhenExpression := TGpSQLExpression.Create;
  FThenExpression := TGpSQLExpression.Create;
end; { TGpSQLCaseWhenThen.Create }

function TGpSQLCaseWhenThen.GetThenExpression: IGpSQLExpression;
begin
  Result := FThenExpression;
end; { TGpSQLCaseWhenThen.GetThenExpression }

function TGpSQLCaseWhenThen.GetWhenExpression: IGpSQLExpression;
begin
  Result := FWhenExpression;
end; { TGpSQLCaseWhenThen.GetWhenExpression }

procedure TGpSQLCaseWhenThen.SetThenExpression(const value: IGpSQLExpression);
begin
  FThenExpression := value;
end; { TGpSQLCaseWhenThen.SetThenExpression }

procedure TGpSQLCaseWhenThen.SetWhenExpression(const value: IGpSQLExpression);
begin
  FWhenExpression := value;
end; { TGpSQLCaseWhenThen.SetWhenExpression }

{ TGpSQLCaseWhenList }

constructor TGpSQLCaseWhenList.Create;
begin
  inherited Create;
  FWhenThenList := TList<IGpSQLCaseWhenThen>.Create;
end; { TGpSQLCaseWhenList.Create }

destructor TGpSQLCaseWhenList.Destroy;
begin
  FreeAndNil(FWhenThenList);
  inherited Destroy;
end; { TGpSQLCaseWhenList.Destroy }

function TGpSQLCaseWhenList.Add: IGpSQLCaseWhenThen;
begin
  Result := TGpSQLCaseWhenThen.Create;
  Add(Result);
end; { TGpSQLCaseWhenList.Add }

function TGpSQLCaseWhenList.Add(const whenThen: IGpSQLCaseWhenThen): integer;
begin
  Result := FWhenThenList.Add(whenThen);
end; { TGpSQLCaseWhenList.Add }

function TGpSQLCaseWhenList.Count: integer;
begin
  Result := FWhenThenList.Count;
end; { TGpSQLCaseWhenList.Count }

function TGpSQLCaseWhenList.GetWhenThen(idx: integer): IGpSQLCaseWhenThen;
begin
  Result := FWhenThenList[idx];
end; { TGpSQLCaseWhenList.GetWhenThen }

procedure TGpSQLCaseWhenList.SetWhenThen(idx: integer; const value: IGpSQLCaseWhenThen);
begin
  FWhenThenList[idx] := value;
end; { TGpSQLCaseWhenList.SetWhenThen }

{ TGpSQLCase }

constructor TGpSQLCase.Create;
begin
  inherited Create;
  FCaseExpression := TGpSQLExpression.Create;
  FElseExpression := TGpSQLExpression.Create;
  FWhenList := TGpSQLCaseWhenList.Create;
end; { TGpSQLCase.Create }

function TGpSQLCase.GetCaseExpression: IGpSQLExpression;
begin
  Result := FCaseExpression;
end; { TGpSQLCase.GetCaseExpression }

function TGpSQLCase.GetElseExpression: IGpSQLExpression;
begin
  Result := FElseExpression;
end; { TGpSQLCase.GetElseExpression }

function TGpSQLCase.GetWhenList: IGpSQLCaseWhenList;
begin
  Result := FWhenList;
end; { TGpSQLCase.GetWhenList }

procedure TGpSQLCase.SetCaseExpression(const value: IGpSQLExpression);
begin
  FCaseExpression := value;
end; { TGpSQLCase.SetCaseExpression }

procedure TGpSQLCase.SetElseExpression(const value: IGpSQLExpression);
begin
  FElseExpression := value;
end; { TGpSQLCase.SetElseExpression }

procedure TGpSQLCase.SetWhenList(const value: IGpSQLCaseWhenList);
begin
  FWhenList := value;
end; { TGpSQLCase.SetWhenList }

{ TGpSQLSection }

constructor TGpSQLSection.Create(sectionName: string);
begin
  inherited Create;
  FName := sectionName;
end; { TGpSQLSection.Create }

function TGpSQLSection.GetName: string;
begin
  Result := FName;
end; { TGpSQLSection.GetName }

{ TGpSQLSelectQualifier }

function TGpSQLSelectQualifier.GetQualifier: TGpSQLSelectQualifierType;
begin
  Result := FQualifier;
end; { TGpSQLSelectQualifier.GetQualifier }

function TGpSQLSelectQualifier.GetValue: integer;
begin
  Result := FValue;
end; { TGpSQLSelectQualifier.GetValue }

procedure TGpSQLSelectQualifier.SetQualifier(const value: TGpSQLSelectQualifierType);
begin
  FQualifier := value;
end; { TGpSQLSelectQualifier.SetQualifier }

procedure TGpSQLSelectQualifier.SetValue(const value: integer);
begin
  FValue := value;
end; { TGpSQLSelectQualifier.SetValue }

{ TGpSQLSelectQualifiers }

constructor TGpSQLSelectQualifiers.Create;
begin
  inherited Create;
  FQualifiers := TList<IGpSQLSelectQualifier>.Create;
end; { TGpSQLSelectQualifiers.Create }

destructor TGpSQLSelectQualifiers.Destroy;
begin
  FreeAndNil(FQualifiers);
  inherited;
end; { TGpSQLSelectQualifiers.Destroy }

function TGpSQLSelectQualifiers.Add: IGpSQLSelectQualifier;
begin
  Result := TGpSQLSelectQualifier.Create;
  Add(Result);
end; { TGpSQLSelectQualifiers.Add }

procedure TGpSQLSelectQualifiers.Add(qualifier: IGpSQLSelectQualifier);
begin
  FQualifiers.Add(qualifier);
end; { TGpSQLSelectQualifiers.Add }

procedure TGpSQLSelectQualifiers.Clear;
begin
  FQualifiers.Clear;
end; { TGpSQLSelectQualifiers.Clear }

function TGpSQLSelectQualifiers.Count: integer;
begin
  Result := FQualifiers.Count;
end; { TGpSQLSelectQualifiers.Count }

function TGpSQLSelectQualifiers.GetQualifier(idx: integer): IGpSQLSelectQualifier;
begin
  Result := FQualifiers[idx];
end; { TGpSQLSelectQualifiers.GetQualifier }

function TGpSQLSelectQualifiers.IsEmpty: boolean;
begin
  Result := (Count = 0);
end; { TGpSQLSelectQualifiers.IsEmpty }

{ TGpSQLSelect }

procedure TGpSQLSelect.Clear;
begin
  Columns.Clear;
  TableName.Clear;
end; { TGpSQLSelect.Clear }

constructor TGpSQLSelect.Create;
begin
  inherited Create('Select');
  FColumns := TGpSQLColumns.Create;
  FQualifiers := TGpSQLSelectQualifiers.Create;
  FTableName := TGpSQLName.Create;
end; { TGpSQLSelect.Create }

function TGpSQLSelect.GetColumns: IGpSQLColumns;
begin
  Result := FColumns;
end; { TGpSQLSelect.GetColumns }

function TGpSQLSelect.GetQualifiers: IGpSQLSelectQualifiers;
begin
  Result := FQualifiers;
end; { TGpSQLSelect.GetQualifiers }

function TGpSQLSelect.GetTableName: IGpSQLName;
begin
  Result := FTableName;
end; { TGpSQLSelect.GetTableName }

function TGpSQLSelect.IsEmpty: boolean;
begin
  Result := Columns.IsEmpty and TableName.IsEmpty;
end; { TGpSQLSelect.IsEmpty }

procedure TGpSQLSelect.SetTableName(const value: IGpSQLName);
begin
  FTableName := value;
end; { TGpSQLSelect.SetTableName }

{ TGpSQLJoin }

procedure TGpSQLJoin.Clear;
begin
  Condition.Clear;
  JoinedTable.Clear;
end; { TGpSQLJoin.Clear }

constructor TGpSQLJoin.Create;
begin
  inherited Create('Join');
  FJoinedTable := TGpSQLName.Create;
  FCondition := TGpSQLExpression.Create;
end; { TGpSQLJoin.Create }

function TGpSQLJoin.GetCondition: IGpSQLExpression;
begin
  Result := FCondition;
end; { TGpSQLJoin.GetCondition }

function TGpSQLJoin.GetJoinedTable: IGpSQLName;
begin
  Result := FJoinedTable;
end; { TGpSQLJoin.GetJoinedTable }

function TGpSQLJoin.GetJoinType: TGpSQLJoinType;
begin
  Result := FJoinType;
end; { TGpSQLJoin.GetJoinType }

function TGpSQLJoin.IsEmpty: boolean;
begin
  Result := Condition.IsEmpty and JoinedTable.IsEmpty;
end; { TGpSQLJoin.IsEmpty }

procedure TGpSQLJoin.SetCondition(const value: IGpSQLExpression);
begin
  FCondition := value;
end; { TGpSQLJoin.SetCondition }

procedure TGpSQLJoin.SetJoinedTable(const value: IGpSQLName);
begin
  FJoinedTable := value;
end; { TGpSQLJoin.SetJoinedTable }

procedure TGpSQLJoin.SetJoinType(const value: TGpSQLJoinType);
begin
  FJoinType := value;
end; { TGpSQLJoin.SetJoinType }

{ TGpSQLJoins }

procedure TGpSQLJoins.Clear;
begin
  FJoins.Clear;
end; { TGpSQLJoins.Clear }

constructor TGpSQLJoins.Create;
begin
  inherited Create;
  FJoins := TList<IGpSQLJoin>.Create;
end; { TGpSQLJoins.Create }

destructor TGpSQLJoins.Destroy;
begin
  FreeAndNil(FJoins);
  inherited;
end; { TGpSQLJoins.Destroy }

function TGpSQLJoins.IsEmpty: boolean;
begin
  Result := (FJoins.Count = 0);
end; { TGpSQLJoins.IsEmpty }

procedure TGpSQLJoins.Add(const join: IGpSQLJoin);
begin
  FJoins.Add(join);
end; { TGpSQLJoins.Add }

function TGpSQLJoins.Add: IGpSQLJoin;
begin
  Result := TGpSQLJoin.Create;
  Add(Result);
end; { TGpSQLJoins.Add }

function TGpSQLJoins.Count: integer;
begin
  Result := FJoins.Count;
end; { TGpSQLJoins.Count }

function TGpSQLJoins.GetJoins(idx: integer): IGpSQLJoin;
begin
  Result := FJoins[idx];
end; { TGpSQLJoins.GetJoins }

procedure TGpSQLJoins.SetJoins(idx: integer; const value: IGpSQLJoin);
begin
  FJoins[idx] := value;
end; { TGpSQLJoins.SetJoins }

{ TGpSQLWhere }

procedure TGpSQLWhere.Clear;
begin
  Expression.Clear;
end; { TGpSQLWhere.Clear }

constructor TGpSQLWhere.Create;
begin
  inherited Create('Where');
  FExpression := TGpSQLExpression.Create;
end; { TGpSQLWhere.Create }

function TGpSQLWhere.GetExpression: IGpSQLExpression;
begin
  Result := FExpression;
end; { TGpSQLWhere.GetExpression }

function TGpSQLWhere.IsEmpty: boolean;
begin
  Result := Expression.IsEmpty;
end; { TGpSQLWhere.IsEmpty }

procedure TGpSQLWhere.SetExpression(const value: IGpSQLExpression);
begin
  FExpression := value;
end; { TGpSQLWhere.SetExpression }

{ TGpSQLGroupBy }

procedure TGpSQLGroupBy.Clear;
begin
  Columns.Clear;
end; { TGpSQLGroupBy.Clear }

constructor TGpSQLGroupBy.Create;
begin
  inherited Create('GroupBy');
  FColumns := TGpSQLColumns.Create;
end; { TGpSQLGroupBy.Create }

function TGpSQLGroupBy.GetColumns: IGpSQLColumns;
begin
  Result := FColumns;
end; { TGpSQLGroupBy.GetColumns }

function TGpSQLGroupBy.IsEmpty: boolean;
begin
  Result := Columns.Isempty;
end; { TGpSQLGroupBy.IsEmpty }

{ TGpSQLHaving }

procedure TGpSQLHaving.Clear;
begin
  Expression.Clear;
end; { TGpSQLHaving.Clear }

constructor TGpSQLHaving.Create;
begin
  inherited Create('Having');
  FExpression := TGpSQLExpression.Create;
end; { TGpSQLHaving.Create }

function TGpSQLHaving.GetExpression: IGpSQLExpression;
begin
  Result := FExpression;
end; { TGpSQLHaving.GetExpression }

function TGpSQLHaving.IsEmpty: boolean;
begin
  Result := Expression.IsEmpty;
end; { TGpSQLHaving.IsEmpty }

{ TGpSQLHaving }

procedure TGpSQLHaving.SetExpression(const value: IGpSQLExpression);
begin
  FExpression := value;
end; { TGpSQLHaving.SetExpression }

{ TGpSQLOrderByColumn }

function TGpSQLOrderByColumn.GetDirection: TGpSQLOrderByDirection;
begin
  Result := FDirection;
end; { TGpSQLOrderByColumn.GetDirection }

procedure TGpSQLOrderByColumn.SetDirection(const value: TGpSQLOrderByDirection);
begin
  FDirection := value;
end; { TGpSQLOrderByColumn.SetDirection }

{ TGpSQLOrderByColumns }

function TGpSQLOrderByColumns.Add: IGpSQLName;
begin
  Result := TGpSQLOrderByColumn.Create;
  Add(Result);
end; { TGpSQLOrderByColumns.Add }

{ TGpSQLOrderBy }

constructor TGpSQLOrderBy.Create;
begin
  inherited Create('OrderBy');
  FColumns := TGpSQLOrderByColumns.Create;
end; { TGpSQLOrderBy.Create }

procedure TGpSQLOrderBy.Clear;
begin
  Columns.Clear;
end; { TGpSQLOrderBy.Clear }

function TGpSQLOrderBy.GetColumns: IGpSQLColumns;
begin
  Result := FColumns;
end; { TGpSQLOrderBy.GetColumns }

function TGpSQLOrderBy.IsEmpty: boolean;
begin
  Result := Columns.IsEmpty;
end; { TGpSQLOrderBy.IsEmpty }

{ TGpSQLAST }

procedure TGpSQLAST.Clear;
begin
  Select.Clear;
  Joins.Clear;
  Where.Clear;
  GroupBy.Clear;
  Having.Clear;
  OrderBy.Clear;
end; { TGpSQLAST.Clear }

constructor TGpSQLAST.Create;
begin
  inherited;
  FSelect := TGpSQLSelect.Create;
  FJoins := TGpSQLJoins.Create;
  FWhere := TGpSQLWhere.Create;
  FGroupBy := TGpSQLGroupBy.Create;
  FHaving := TGpSQLHaving.Create;
  FOrderBy := TGpSQLOrderBy.Create;
end; { TGpSQLAST.Create }

function TGpSQLAST.GetGroupBy: IGpSQLGroupBy;
begin
  Result := FGroupBy;
end; { TGpSQLAST.GetGroupBy }

function TGpSQLAST.GetHaving: IGpSQLHaving;
begin
  Result := FHaving;
end; { TGpSQLAST.GetHaving }

function TGpSQLAST.GetJoins: IGpSQLJoins;
begin
  Result := FJoins;
end;

function TGpSQLAST.GetOrderBy: IGpSQLOrderBy;
begin
  Result := FOrderBy;
end; { TGpSQLAST.GetOrderBy }

function TGpSQLAST.GetSelect: IGpSQLSelect;
begin
  Result := FSelect;
end; { TGpSQLAST.GetSelect }

function TGpSQLAST.GetWhere: IGpSQLWhere;
begin
  Result := FWhere;
end; { TGpSQLAST.GetWhere }

function TGpSQLAST.IsEmpty: boolean;
begin
  Result :=
    Select.IsEmpty and
    Joins.IsEmpty and
    Where.IsEmpty and
    GroupBy.IsEmpty and
    Having.IsEmpty and
    OrderBy.IsEmpty;
end; { TGpSQLAST.IsEmpty }

end.