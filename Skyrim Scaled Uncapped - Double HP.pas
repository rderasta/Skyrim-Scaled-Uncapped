{
  Flag NPCs with Level Mult and calculate mult based on old level.
  Equals Player's Level - Rastoid version
  LevelMult=New Formula
}
unit userscript;

uses mteFunctions;

function Process(e: IInterface): integer;

var

 iOldLevel, iNewLevel, iShift, iBase, iHealth, iHealthPlus, iStam, iStamPlus, iMgk, iMgkPlus, iMult : integer;
	
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
		
		
		// User can cuztomize iBase and/or iShift (not recomended) below.
		// Default: 800
		iBase := 800;		
		// Default: 10
		iShift := 20;
  	
   	iOldLevel := GetElementNativeValues(e, 'ACBS\Level');
		iNewLevel := iOldLevel * iShift;
	 
	SetElementNativeValues(e, 'ACBS\Flags', GetElementNativeValues(e, 'ACBS\Flags') or 16);
 	SetElementNativeValues(e, 'ACBS\Flags', GetElementNativeValues(e, 'ACBS\Flags') or 128);
	  
	SetElementNativeValues(e, 'ACBS\Level Mult',(iNewLevel + iBase));

	// This changes Starting Health value of races.	

		// Default: 2
		iMult := 2;
				
	if Signature(e) = 'RACE' then
	
    		iHealth := GetElementNativeValues(e, 'DATA - DATA\Starting Health');
				 
			SetElementNativeValues(e, 'DATA - DATA\Starting Health',(iHealth * iMult));
			
		iStam := GetElementNativeValues(e, 'DATA - DATA\Starting Stamina');
		iStamPlus := iStam / iMult;
		 
			SetElementNativeValues(e, 'DATA - DATA\Starting Stamina',(iStam + iStamPlus));
		
		iMgk := GetElementNativeValues(e, 'DATA - DATA\Starting Magicka');
		iMgkPlus := iMgk / iMult;
		 
			SetElementNativeValues(e, 'DATA - DATA\Starting Magicka',(iMgk + iMgkPlus));
 end;



// Cleanup
function Finalize: integer;
	begin

		Result := 1;

	end; // end function

end. // end script

