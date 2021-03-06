SELECT * 
  FROM INFORMATION_SCHEMA.ROUTINES
 WHERE ROUTINE_TYPE = 'PROCEDURE' 
   AND LEFT(ROUTINE_NAME, 3) NOT IN ('sp_', 'xp_', 'ms_')
ORDER BY ROUTINE_NAME


SELECT  
   'Parameter' = name,  
   'Type'   = type_name(user_type_id),  
   'Length'   = max_length,  
   'Precision'   = case when type_name(system_type_id) = 'uniqueidentifier' 
              then precision  
              else OdbcPrec(system_type_id, max_length, precision) end,  
   'Scale'   = OdbcScale(system_type_id, scale),  
   'Order'  = parameter_id,  
   'Collation'   = convert(sysname, 
                   case when system_type_id in (35, 99, 167, 175, 231, 239)  
                   then ServerProperty('collation') end),
	is_Output = CAST(is_Output AS INT),
	is_nullable = CAST(is_nullable AS INT)
  from sys.parameters where object_id = object_id('dbo.Material_INITIALIZE')
  ORDER BY parameter_id

exec sp_describe_first_result_set N'dbo.[Customer_GET_Contact]'
