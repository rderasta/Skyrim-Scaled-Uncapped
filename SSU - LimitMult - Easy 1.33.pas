{
  Checks for mult value and if its above desired limit it will change to custom value.
  Skyrim Scaled Uncapped - By Rasta
}
unit userscript;

uses mteFunctions;

function Process(e: IInterface): integer;

var

 iCheckMult, iLimit : integer;
	
begin
 Result := 0;

if Signature(e) = 'NPC_' then
		
		// Change limit to desired value, default: 1600 = 1.6
		// E.g: 1300 = 1.3
		iLimit := 1333;
		
	iCheckMult := GetElementNativeValues(e, 'ACBS\Level Mult');
		if iCheckMult > iLimit then
		SetElementNativeValues(e, 'ACBS\Level Mult',(iLimit));
		
	end;
	
	// Cleanup
function Finalize: integer;
	begin

		Result := 1;

	end; // end function

end. // end script
