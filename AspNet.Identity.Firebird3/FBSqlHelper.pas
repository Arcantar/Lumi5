namespace ;

interface

uses
  System,
  System.Data,
  FirebirdSql.Data.FirebirdClient,
  FirebirdSql.Data.Isql;


type
  FBSqlHelper = public sealed class
  private
    constructor ;

  public
    class method GetParamString(count: Int32): String;

  private
    class var connection: FbConnection := nil;

    class method PrepareCommand(command: FbCommand; connection: FbConnection; transaction: FbTransaction; commandType: CommandType; commandText: System.String; commandParameters: array of FbParameter);

    class method AttachParameters(command: FbCommand; commandParameters: array of FbParameter);

  public
    class method ExecuteBatchScript(connectionString: System.String; pathToScriptFile: System.String): System.Boolean;

    class method ExecuteNonQuery(connectionString: System.String; commandText: System.String; params commandParameters: array of FbParameter): System.Int32;

    class method ExecuteNonQuery(connectionString: System.String; commandType: CommandType; commandText: System.String; params commandParameters: array of FbParameter): System.Int32;

    class method ExecuteNonQuery(transaction: FbTransaction; commandType: CommandType; commandText: System.String; params commandParameters: array of FbParameter): System.Int32;

    class method ExecuteNonQuery(connection: FbConnection; commandType: CommandType; commandText: System.String; params commandParameters: array of FbParameter): System.Int32;
   
    class method ExecuteReader(connectionString: System.String; commandText: System.String; params commandParameters: array of FbParameter): FbDataReader;

    class method ExecuteReader(connectionString: System.String; commandType: CommandType; commandText: System.String; params commandParameters: array of FbParameter): FbDataReader;

    class method ExecuteReader(connection: FbConnection; commandText: System.String; params commandParameters: array of FbParameter): FbDataReader;

    class method ExecuteReader(connection: FbConnection; commandType: CommandType; commandText: System.String; params commandParameters: array of FbParameter): FbDataReader;

    class method ExecuteReaderW(connectionString: System.String; commandType: CommandType; commandText: System.String; params commandParameters: array of FbParameter): FbDataReader;

    class method ExecuteScalar(connectionString: System.String; commandText: System.String; params commandParameters: array of FbParameter): System.Object;

    class method ExecuteScalar(connectionString: System.String; commandType: CommandType; commandText: System.String; params commandParameters: array of FbParameter): System.Object;

    class method ExecuteScalar(connection: FbConnection; commandType: CommandType; commandText: System.String; params commandParameters: array of FbParameter): System.Object;

    class method ExecuteDataset(connectionString: System.String; commandText: System.String; params commandParameters: array of FbParameter): DataSet;

    class method ExecuteDataset(connectionString: System.String; commandType: CommandType; commandText: System.String; params commandParameters: array of FbParameter): DataSet;

    class method ExecuteDataTable(connectionString: System.String; commandText: System.String): DataTable;

    class method ExecuteDataTable(connectionString: System.String; commandText: System.String; params commandParameters: array of FbParameter): DataTable;

    class method ExecuteDataTable(connectionString: System.String; commandType: CommandType; commandText: System.String; params commandParameters: array of FbParameter): DataTable;
    
    class method ExecuteDataTable(transaction: FbTransaction; commandType: CommandType; commandText: System.String; params commandParameters: array of FbParameter): DataTable;

    class method ServerVersion(connectionString : System.String):String;

  end;




implementation



constructor FBSqlHelper;
begin

end;

class method FBSqlHelper.GetParamString(count: Int32): String;
begin
  if count <= 1 then begin
    exit iif(count < 1, '', '?')
  end;
  exit '?,' + GetParamString(count - 1)
end;

class method FBSqlHelper.PrepareCommand(command: FbCommand; connection: FbConnection; transaction: FbTransaction; commandType: CommandType; commandText: System.String; commandParameters: array of FbParameter);
begin
  if command = nil then    raise new ArgumentNullException('command');
  if (commandText = nil) or (commandText.Length = 0) then    raise new ArgumentNullException('commandText');

  command.Connection := connection;
  command.CommandText := commandText;
  command.CommandType := commandType;

  if transaction <> nil then begin
    if transaction.Connection = nil then      raise new ArgumentException('The transaction was rollbacked or commited, please provide an open transaction.', 'transaction');
    command.Transaction := transaction
  end;

  if commandParameters <> nil then begin
    AttachParameters(command, commandParameters)
  end;
  exit
end;

class method FBSqlHelper.AttachParameters(command: FbCommand; commandParameters: array of FbParameter);
begin
  if command = nil then    raise new ArgumentNullException('command');
  if commandParameters <> nil then begin
    for each p: FbParameter in commandParameters do begin
      if p <> nil then begin
        if (((p.Direction = ParameterDirection.InputOutput) or (p.Direction = ParameterDirection.Input))) and ((p.Value = nil)) then begin
          p.Value := DBNull.Value
        end;
        command.Parameters.Add(p)
      end
    end
  end
end;

class method FBSqlHelper.ExecuteBatchScript(connectionString: System.String; pathToScriptFile: System.String): System.Boolean;
begin

  var sr: System.IO.StreamReader := System.IO.File.OpenText(pathToScriptFile);
  var script: FbScript := new FbScript(sr.ReadToEnd);
  if script.Parse() > 0 then begin
    using connection: FbConnection := new FbConnection(connectionString) do begin
      connection.Open();
      try
        var batch: FbBatchExecution := new FbBatchExecution(connection);      
        for each cmd: System.String in script.Results do begin
          batch.SqlStatements.Add(cmd);
        end;
        batch.Execute(true);// true = auto commit !
      finally
        sr.Close;
      except        on ex: FbException do begin
          raise new Exception(pathToScriptFile, ex)
        end;
      end
    end
  end;
  exit true
end;


class method FBSqlHelper.ExecuteNonQuery(connectionString: System.String; commandText: System.String; params commandParameters: array of FbParameter): System.Int32;
begin
  exit ExecuteNonQuery(connectionString, CommandType.Text, commandText, commandParameters)
end;

class method FBSqlHelper.ExecuteNonQuery(connectionString: System.String; commandType: CommandType; commandText: System.String; params commandParameters: array of FbParameter): System.Int32;
begin
  if (connectionString = nil) or (connectionString.Length = 0) then begin
    raise new ArgumentNullException('connectionString')
  end;

  using connection: FbConnection := new FbConnection(connectionString) do begin
    connection.Open();
    using transaction: FbTransaction := connection.BeginTransaction() do begin
      using cmd: FbCommand := new FbCommand() do begin
        PrepareCommand(cmd, connection, transaction, commandType, commandText, commandParameters);
        var rowsAffected: System.Int32 := 0;      
        try
        rowsAffected:= cmd.ExecuteNonQuery();
        transaction.Commit();
        //transaction.Dispose;
        except         on ex: FbException do begin
          rowsAffected := 0;
          transaction.Rollback;
          transaction.Dispose;
          connection.Close;
          connection.Dispose;
          raise new Exception('ExecuteNonQuery '+#13#10+commandText+#13#10+ex, ex)
        end;
        end;
        exit rowsAffected
      end
    end
  end
end;

class method FBSqlHelper.ExecuteNonQuery(connection: FbConnection; commandType: CommandType; commandText: System.String; params commandParameters: array of FbParameter): System.Int32;
begin
    if (connection = nil) then raise new ArgumentNullException('connectionString');
    if ((connection <> nil)) and ((connection.State = ConnectionState.Closed)) then
    connection.Open();
    using transaction: FbTransaction := connection.BeginTransaction() do begin
      using cmd: FbCommand := new FbCommand() do begin
        PrepareCommand(cmd, connection, transaction, commandType, commandText, commandParameters);
        var rowsAffected: System.Int32 := 0;      
        try
        rowsAffected:= cmd.ExecuteNonQuery();
        transaction.Commit();
        //transaction.Dispose;
        except         on ex: FbException do begin
          rowsAffected := 0;
          transaction.Rollback;
          transaction.Dispose;
          connection.Close;
          raise new Exception('ExecuteNonQuery '+#13#10+commandText+#13#10+ex, ex)
        end;
        end;
        exit rowsAffected
      end
    end
  
end;

class method FBSqlHelper.ExecuteNonQuery(transaction: FbTransaction; commandType: CommandType; commandText: System.String; params commandParameters: array of FbParameter): System.Int32;
begin
  if transaction = nil then    raise new ArgumentNullException('transaction');

  var cmd: FbCommand := new FbCommand();
    
     PrepareCommand(cmd, transaction.Connection, transaction, commandType, commandText, commandParameters);
     var retval: System.Int32 := cmd.ExecuteNonQuery();
    
     exit retval
 
end;

class method FBSqlHelper.ExecuteReader(connectionString: System.String; commandText: System.String; params commandParameters: array of FbParameter): FbDataReader;
begin
  exit ExecuteReader(connectionString, CommandType.Text, commandText, commandParameters)
end;

class method FBSqlHelper.ExecuteReader(connectionString: System.String; commandType: CommandType; commandText: System.String; params commandParameters: array of FbParameter): FbDataReader;
begin
  if (connectionString = nil) or (connectionString.Length = 0) then    raise new ArgumentNullException('connectionString');
  var connection: FbConnection := nil;
  try
    connection := new FbConnection(connectionString);
    connection.Open();
    var command: FbCommand := new FbCommand();
    var transaction: FbTransaction := nil;
    var useTransaction: System.Boolean := ((commandText.Contains('EXECUTE')) or (commandText.Contains('INSERT')) or (commandText.Contains('UPDATE')) or (commandText.Contains('DELETE')));
    if useTransaction then begin
      transaction := connection.BeginTransaction()
    end;
    PrepareCommand(command, connection, transaction, commandType, commandText, commandParameters);    
     
    var rd : FbDataReader := command.ExecuteReader(CommandBehavior.CloseConnection);
 
    if transaction <> nil then begin
        try
          if useTransaction then begin
            transaction.Commit();
            //transaction.Dispose();
            transaction := nil;
          end;
        except        on ex: FbException do begin
          transaction.Rollback;
          transaction.Dispose;
          if ((connection <> nil)) and ((connection.State = ConnectionState.Open)) then begin
             connection.Close;
             connection.Dispose;
          end;
          raise new Exception('execute Reader', ex)
        end;
        end;
      end;
     exit rd;

  except on ex: FbException do begin
      if ((connection <> nil)) and ((connection.State = ConnectionState.Open)) then begin
        connection.Close()
      end;
      connection.Dispose;
      raise 
    end;
  end
end;

class method FBSqlHelper.ExecuteReader(connection: FbConnection; commandText: System.String; params commandParameters: array of FbParameter): FbDataReader;
begin
  exit ExecuteReader(connection, CommandType.Text, commandText, commandParameters)
end;

class method FBSqlHelper.ExecuteReader(connection: FbConnection; commandType: CommandType; commandText: System.String; params commandParameters: array of FbParameter): FbDataReader;
begin
  if (connection = nil)  then    raise new ArgumentNullException('connection');
  if (connection.ConnectionString = nil)  then    raise new ArgumentNullException('connectionstring is null');
  try    
   if ((connection <> nil)) and ((connection.State = ConnectionState.Closed)) then
    connection.Open();
    var command: FbCommand := new FbCommand();
    var transaction: FbTransaction := nil;
    var useTransaction: System.Boolean := ((commandText.Contains('EXECUTE')) or (commandText.Contains('INSERT')) or (commandText.Contains('UPDATE')) or (commandText.Contains('DELETE')));
    if useTransaction then begin
      transaction := connection.BeginTransaction()
    end;
    PrepareCommand(command, connection, transaction, commandType, commandText, commandParameters);    
     
    var rd : FbDataReader := command.ExecuteReader(CommandBehavior.CloseConnection);
 
    if transaction <> nil then begin
        try
          if useTransaction then begin
            transaction.Commit();
            //transaction.Dispose();
            //transaction := nil;
          end;
        except        on ex: FbException do begin
          transaction.Rollback;
          transaction.Dispose;
          if ((connection <> nil)) and ((connection.State = ConnectionState.Open)) then begin
             connection.Close;
             //connection.Dispose;
          end;
          raise new Exception('execute Reader', ex)
        end;
        end;
      end;
     exit rd;

  except on ex: FbException do begin
      if ((connection <> nil)) and ((connection.State = ConnectionState.Open)) then begin
        connection.Close()
      end;
      //connection.Dispose;
      raise 
    end;
  end
end;

class method FBSqlHelper.ExecuteReaderW(connectionString: System.String; commandType: CommandType; commandText: System.String; params commandParameters: array of FbParameter): FbDataReader;
begin
  if (connectionString = nil) or (connectionString.Length = 0) then    raise new ArgumentNullException('connectionString');
  var connection: FbConnection := nil;
  try
    connection := new FbConnection(connectionString);
    connection.Open();

    var command: FbCommand := new FbCommand();

    var transaction: FbTransaction := nil;
    var useTransaction: System.Boolean := true;
    if useTransaction then begin
      transaction := connection.BeginTransaction;
    end;


    PrepareCommand(command, connection, transaction, commandType, commandText, commandParameters);
      
     
    var rd : FbDataReader := command.ExecuteReader(CommandBehavior.CloseConnection);
 
    if transaction <> nil then begin
        try
      if useTransaction then
        transaction.Commit();
        transaction.Dispose();
        transaction := nil
        except        on ex: FbException do begin
          connection.Close;
          connection.Dispose;
          raise new Exception('execute Reader', ex)
        end;
        end;
      end;
     exit rd;

  except begin
      if ((connection <> nil)) and ((connection.State = ConnectionState.Open)) then begin
        connection.Close()
      end;
      raise 
    end;
  end
end;


class method FBSqlHelper.ExecuteScalar(connectionString: System.String; commandText: System.String; params commandParameters: array of FbParameter): System.Object;
begin
  exit ExecuteScalar(connectionString, CommandType.Text, commandText, commandParameters)
end;

class method FBSqlHelper.ExecuteScalar(connectionString: System.String; commandType: CommandType; commandText: System.String; params commandParameters: array of FbParameter): System.Object;
begin
  if (connectionString = nil) or (connectionString.Length = 0) then    raise new ArgumentNullException('connectionString');
  
  using connection: FbConnection := new FbConnection(connectionString) do begin
   connection.Open();
    var transaction: FbTransaction := nil;
    var useTransaction: System.Boolean := ((commandText.Contains('EXECUTE')) or (commandText.Contains('INSERT')) or (commandText.Contains('UPDATE')) or (commandText.Contains('DELETE')));
    if useTransaction then begin
      transaction := connection.BeginTransaction()
    end;

    using command: FbCommand := new FbCommand() do begin
       try   
      PrepareCommand(command, connection, transaction, commandType, commandText, commandParameters);
      
      var ob : System.Object:= command.ExecuteScalar();

      if transaction <> nil then begin
        try
        if useTransaction then begin
          transaction.Commit();
          transaction.Dispose();
          transaction := nil;
        end;
        //transaction := nil
        except        on ex: FbException do begin
          connection.Close;
          raise new Exception('ExecuteScalar', ex)
        end;
        end;
      end;

     // if connection.State = ConnectionState.Open then        connection.Close();

      exit ob;

      except begin
      if ((connection <> nil)) and ((connection.State = ConnectionState.Open)) then begin
        connection.Close()
      end;
      raise 
    end;
    end;
    end;

  end
end;

class method FBSqlHelper.ExecuteScalar(connection: FbConnection; commandType: CommandType; commandText: System.String; params commandParameters: array of FbParameter): System.Object;
begin
  if (connection = nil) then    raise new ArgumentNullException('connection');
  
  using connection do begin
   if ((connection <> nil)) and ((connection.State = ConnectionState.Closed)) then
   connection.Open();
    var transaction: FbTransaction := nil;
    var useTransaction: System.Boolean := ((commandText.Contains('EXECUTE')) or (commandText.Contains('INSERT')) or (commandText.Contains('UPDATE')) or (commandText.Contains('DELETE')));
    if useTransaction then begin
      transaction := connection.BeginTransaction()
    end;

    using command: FbCommand := new FbCommand() do begin
       try   
      PrepareCommand(command, connection, transaction, commandType, commandText, commandParameters);
      
      var ob : System.Object:= command.ExecuteScalar();

      if transaction <> nil then begin
        try
        if useTransaction then begin
          transaction.Commit();
          transaction.Dispose();
          transaction := nil;
        end;
        except        on ex: FbException do begin
          connection.Close;
          raise new Exception('ExecuteScalar', ex)
        end;
        end;
      end;
      exit ob;
      except begin
      if ((connection <> nil)) and ((connection.State = ConnectionState.Open)) then begin
        connection.Close()
      end;
      raise 
    end;
    end;
    end;

  end
end;

class method FBSqlHelper.ExecuteDataset(connectionString: System.String; commandText: System.String; params commandParameters: array of FbParameter): DataSet;
begin
  exit ExecuteDataset(connectionString, CommandType.Text, commandText, commandParameters)
end;

class method FBSqlHelper.ExecuteDataset(connectionString: System.String; commandType: CommandType; commandText: System.String; params commandParameters: array of FbParameter): DataSet;
begin
  if (connectionString = nil) or (connectionString.Length = 0) then    raise new ArgumentNullException('connectionString');

  using connection: FbConnection := new FbConnection(connectionString) do begin
    connection.Open();
    using command: FbCommand := new FbCommand() do begin
      using transaction: FbTransaction := connection.BeginTransaction() do begin
        PrepareCommand(command, connection, transaction, commandType, commandText, commandParameters);
         using adapter: FbDataAdapter := new FbDataAdapter(command) do begin
            var dataSet: DataSet := new DataSet();
            adapter.Fill(dataSet);
            if transaction <> nil then begin
              try
              transaction.Commit();
              transaction.Dispose();
              transaction := nil
              except on ex: FbException do begin                
                 raise new Exception('ExecuteDataset DataSet', ex)
               end;
              end;
            end;
            exit dataSet
         end
      end;
    end
  end
end;

class method FBSqlHelper.ExecuteDataTable(connectionString: System.String; commandText: System.String): DataTable;
begin
  exit ExecuteDataTable(connectionString, CommandType.Text, commandText, nil)
end;

class method FBSqlHelper.ExecuteDataTable(connectionString: System.String; commandText: System.String; params commandParameters: array of FbParameter): DataTable;
begin
  exit ExecuteDataTable(connectionString, CommandType.Text, commandText, commandParameters)
end;

class method FBSqlHelper.ExecuteDataTable(connectionString: System.String; commandType: CommandType; commandText: System.String; params commandParameters: array of FbParameter): DataTable;
begin
  if (connectionString = nil) or (connectionString.Length = 0) then    raise new ArgumentNullException('connectionString');

  using connection: FbConnection := new FbConnection(connectionString) do begin
    connection.Open();
    using command: FbCommand := new FbCommand() do begin
      using transaction: FbTransaction := connection.BeginTransaction() do begin
        PrepareCommand(command, connection, transaction, commandType, commandText, commandParameters);
         using adapter: FbDataAdapter := new FbDataAdapter(command) do begin
            var dataSet: DataSet := new DataSet();
            adapter.Fill(dataSet);
            if transaction <> nil then begin
              try
              transaction.Commit();
              transaction.Dispose();
              transaction := nil
              except on ex: FbException do begin
                 raise new Exception('Execute DataTable', ex)
               end;
              end;
            end;
            exit dataSet.Tables[0]
         end
      end;
    end
  end
end;

class method FBSqlHelper.ExecuteDataTable(transaction: FbTransaction; commandType: CommandType; commandText: System.String; params commandParameters: array of FbParameter): DataTable;
begin
  if transaction = nil then    raise new ArgumentNullException('transaction');

  var cmd: FbCommand := new FbCommand();
    
     PrepareCommand(cmd, transaction.Connection, transaction, commandType, commandText, commandParameters);
     using adapter: FbDataAdapter := new FbDataAdapter(cmd) do begin
       var dataSet: DataSet := new DataSet();
       adapter.Fill(dataSet);
       exit dataSet.Tables[0]
     end
 
end;

class method FBSqlHelper.ServerVersion(connectionString: System.String): String;
begin
  if (connectionString = nil) or (connectionString.Length = 0) then    raise new ArgumentNullException('connectionString');
  var connection: FbConnection := nil;

 //   if (connection = nil) then
    connection := new FbConnection(connectionString);
 //   if (connection.State = ConnectionState.Closed) then
    connection.Open();

var fbi: FbDatabaseInfo := new FbDatabaseInfo(connection);
var fresult : System.String := fbi.IscVersion.ToString; // .DbId.ToString();
connection.Close();
exit fresult;

end;

end.
