{
  Flag NPCs with Level Mult and calculate mult based on old level.
  Skyrim Scaled Uncapped - Races untouched
  LevelMult=New Formula
}
unit userscript;

uses mteFunctions;

function Process(e: IInterface): integer;

var

 iOldLevel, iNewLevel, iShift, iBase, iHealth, iNewHealth, iOffShift, iMult : integer;
	
begin
 Result := 0;

// This uncapps all encounter zones

		if Signature(e) = 'ECZN' then
		SetElementNativeValues(e, 'DATA - DATA\Min level', 1);
		SetElementNativeValues(e, 'DATA - DATA\Max level', 0);

		SetElementNativeValues(e, 'DATA - DATA\Flags\Never Resets', 0);
	
// NPC Scaling begins here

	if Signature(e) = 'NPC_' then

	SetElementNativeValues(e, 'ACBS\Calc min level', 1);
  	SetElementNativeValues(e, 'ACBS\Calc max level', 0);

	if Signature(e) = 'NPC_' then
	
	if GetElementNativeValues(e, 'ACBS\Flags\PC Level Mult') then exit;
		
		// User can customize iBase and/or iShift below.
		iBase := 800;
		iShift := 20;
  	
   	iOldLevel := GetElementNativeValues(e, 'ACBS\Level');
		
		// Result of NewLevel will get divided by 1000.
		// Example and default: ((OldLevel * 10) + 800) / 1000 = NewMultiplier
		iNewLevel := iOldLevel * iShift;
	 
	SetElementNativeValues(e, 'ACBS\Flags', GetElementNativeValues(e, 'ACBS\Flags') or 16);
 	SetElementNativeValues(e, 'ACBS\Flags', GetElementNativeValues(e, 'ACBS\Flags') or 128);
	
	SetElementNativeValues(e, 'ACBS\Level Mult',(iNewLevel + iBase));
		
 end;



// Cleanup
function Finalize: integer;
	begin

		Result := 1;

	end; // end function

end. // end script

