namespace AspNet.Identity.Firebird3;

interface

uses
  FirebirdSql.Data.FirebirdClient,
  System,
  System.Collections.Generic,
  System.Configuration,
  System.Data,
  System.Threading;

type
  /// <summary>
  /// Class that encapsulates a FirebirdSQL Database connections
  /// and CRUD operations
  /// </summary>
  FBDatabase = public class(IDisposable)
  private
   // var _connection: FbConnection;
    var _connectionstring : String;
    method dbConnection_StateChange(sender: Object; ev: StateChangeEventArgs);
  public
    /// Default constructor which uses the "DefaultConnection" connectionString
    /// </summary>
    constructor;
    /// <summary>
    /// Constructor which takes the connection string name
    /// </summary>
    /// <param name="connectionStringName"></param>
    constructor(connectionStringName: String);
    /// <summary>
    /// Executes a non-query FBDatabase statement
    /// </summary>
    /// <param name="commandText">The FBDatabase query to execute</param>
    /// <param name="parameters">Optional parameters to pass to the query</param>
    /// <returns>The count of records affected by the FBDatabase statement</returns>
    method Execute(commandText: String; parameters: Dictionary<String, Object>): Integer;
    /// <summary>
    /// Executes a FBDatabase query that returns a single scalar value as the result.
    /// </summary>
    /// <param name="commandText">The FBDatabase query to execute</param>
    /// <param name="parameters">Optional parameters to pass to the query</param>
    /// <returns></returns>
    method QueryValue(commandText: String; parameters: Dictionary<String, Object>): Object;
    /// <summary>
    /// Executes a SQL query that returns a list of rows as the result.
    /// </summary>
    /// <param name="commandText">The Firebird3 query to execute</param>
    /// <param name="parameters">Parameters to pass to the Firebird3 query</param>
    /// <returns>A list of a Dictionary of Key, values pairs representing the
    /// ColumnName and corresponding value</returns>
    method Query(commandText: String; parameters: Dictionary<String, Object>): List<Dictionary<String, String>>;
    /// <summary>
    /// Executes a SQL query that returns a iDataReader as the result.
    /// </summary>
    /// <param name="commandText">The Firebird3 query to execute</param>
    /// <param name="parameters">Parameters to pass to the Firebird3 query</param>
    /// <returns>iDataReader</returns>
    method QueryToReader(commandText: String; parameters: Dictionary<String, Object>): IDataReader;
  private
    /// <summary>
    /// Opens a connection if not open
    /// </summary>
    method EnsureConnectionOpen;
  public
    /// <summary>
    /// Closes a connection if open
    /// </summary>
    method EnsureConnectionClosed;
  private
    /// <summary>
    /// Creates a FBDatabaseCommand with the given parameters
    /// </summary>
    /// <param name="commandText">The FBDatabase query to execute</param>
    /// <param name="parameters">Parameters to pass to the FBDatabase query</param>
    /// <returns></returns>
    method CreateCommand(commandText: String; parameters: Dictionary<String, Object>): FbCommand;
    /// <summary>
    /// Adds the parameters to a FBDatabase command
    /// </summary>
    /// <param name="commandText">The FBDatabase query to execute</param>
    /// <param name="parameters">Parameters to pass to the FBDatabase query</param>
    class method AddParameters(command: FbCommand; parameters: Dictionary<String, Object>);
  public
    /// <summary>
    /// Helper method to return query a string value
    /// </summary>
    /// <param name="commandText">The FBDatabase query to execute</param>
    /// <param name="parameters">Parameters to pass to the FBDatabase query</param>
    /// <returns>The string value resulting from the query</returns>
    method GetStrValue(commandText: String; parameters: Dictionary<String, Object>): String;
   // property connection :FbConnection read _connection; 
    property connectionString :String read _connectionstring; 

    method Dispose;
  end;

implementation

constructor FBDatabase;
begin
    _connectionstring := ConfigurationManager.ConnectionStrings['DefaultConnection'].ConnectionString;
 // _connection := new FbConnection(_connectionstring);
 // _connection.StateChange += dbConnection_StateChange;
end;

constructor FBDatabase(connectionStringName: String);
begin
  _connectionstring := ConfigurationManager.ConnectionStrings[connectionStringName].ConnectionString;
  //_connection := new FbConnection(_connectionstring);
 // _connection.StateChange += dbConnection_StateChange;
end;

method FBDatabase.Execute(commandText: String; parameters: Dictionary<String, Object>): Integer;
begin
  var fresult: Integer := 0;
  if String.IsNullOrEmpty(commandText) then begin
    raise new ArgumentException('Command text cannot be null or empty.');
  end;
  try
    EnsureConnectionOpen();
    var command:FbCommand := CreateCommand(commandText, parameters);
    fresult := command.ExecuteNonQuery();
  finally
   // _connection.Close();
  end;
  exit fresult;
end;

method FBDatabase.QueryValue(commandText: String; parameters: Dictionary<String, Object>): Object;
begin
  var fresult: Object := nil;
  if String.IsNullOrEmpty(commandText) then begin
    raise new ArgumentException('Command text cannot be null or empty.');
  end;
  try
    EnsureConnectionOpen();
    var command := CreateCommand(commandText, parameters);
    fresult := command.ExecuteScalar();
  finally
    EnsureConnectionClosed();
  end;
  exit fresult;
end;

method FBDatabase.Query(commandText: String; parameters: Dictionary<String, Object>): List<Dictionary<String, String>>;
begin
  var rows: List<Dictionary<String, String>> := nil;
  if String.IsNullOrEmpty(commandText) then begin
    raise new ArgumentException('Command text cannot be null or empty.');
  end;
  try
    EnsureConnectionOpen();
    var command := CreateCommand(commandText, parameters);
    using  reader: FbDataReader := command.ExecuteReader() do
    begin
      rows := new List<Dictionary<String, String>>();
      while reader.Read() do begin
        var row := new Dictionary<String, String>();
        for i:Int32 := 0 to reader.FieldCount-1 do begin
          var columnName := reader.GetName(i);
          var columnValue := if reader.IsDBNull(i) then nil else reader.GetString(i);
          row.Add(columnName, columnValue);
        end;
        rows.Add(row);
      end;
    end;
  finally
    EnsureConnectionClosed();
  end;
  exit rows;
end;

method FBDatabase.QueryToReader(commandText: String; parameters: Dictionary<String, Object>): IDataReader;
begin
 // var rows: List<Dictionary<String, String>> := nil;
  if String.IsNullOrEmpty(commandText) then begin
    raise new ArgumentException('Command text cannot be null or empty.');
  end;
  var reader: FbDataReader;
    EnsureConnectionOpen();
    var command := CreateCommand(commandText, parameters);
    reader:= command.ExecuteReader(CommandBehavior.CloseConnection);
  exit reader;
end;


method FBDatabase.EnsureConnectionOpen;
begin
//  var retries := 3;
//  if _connection.State = ConnectionState.Open then begin
//    exit;
//  end
//  else begin
//    while (retries >= 0) and (_connection.State <> ConnectionState.Open) do begin
//      _connection.Open();
//      dec(retries);
//    end;
//  end;
end;

method FBDatabase.EnsureConnectionClosed;
begin
//  if _connection.State = ConnectionState.Open then begin
//   //yeps !!! _connection.Close();
//  end;
end;

method FBDatabase.CreateCommand(commandText: String; parameters: Dictionary<String, Object>): FbCommand;
begin
//  var command: FbCommand := _connection.CreateCommand();
//  command.CommandText := commandText;
//  AddParameters(command, parameters);
//  exit command;
end;

class method FBDatabase.AddParameters(command: FbCommand; parameters: Dictionary<String, Object>);
begin
  if parameters = nil then begin
    exit;
  end;
  for each param in parameters do begin
    var parameter := command.CreateParameter();
    parameter.ParameterName := param.Key;
    parameter.Value := param.Value ;
    command.Parameters.Add(parameter);
  end;
end;

method FBDatabase.GetStrValue(commandText: String; parameters: Dictionary<String, Object>): String;
begin
  var value: String := String(QueryValue(commandText, parameters));
  exit value;
end;

method FBDatabase.Dispose;
begin
//  if _connection <> nil then begin
//    _connection.Dispose();
//    _connection := nil;
//  end;
end;

method FBDatabase.dbConnection_StateChange(sender: Object; ev: StateChangeEventArgs);
begin
var ar : String;

ar := ev.CurrentState.ToString;
if ar = 'Closed' then
  ar := 'merdouille';


end;




end.
