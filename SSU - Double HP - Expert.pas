{
  Flag NPCs with Level Mult and calculate mult based on old level.
  Also makes slights additions to RACE Starting values.
  Skyrim Scaled Uncapped - By Rasta
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

		// Note: This value will get divided by 1000. 
		// Default: 800 / 1000 = 0.80 - this would be the level multiplier if set to 800.
		// This value acts as a base mult. 
		// The weight of the OldLevel will be added to this.
		// You can tune it down as you please. Going up isn't recomended unless you want hell.
		iBase := 999;
		
		// This value will get divided by 1000 
		// This factor is multiplied with old NPC level and result will be added to Base (= new level). Go easy.
		iShift := 10;
  	
   	iOldLevel := GetElementNativeValues(e, 'ACBS\Level');
		
		// Result of NewLevel will get divided by 1000.
		// Example and default: ((OldLevel * 10) + 800) / 1000 = NewMultiplier
		iNewLevel := iOldLevel * iShift;
	 
	SetElementNativeValues(e, 'ACBS\Flags', GetElementNativeValues(e, 'ACBS\Flags') or 16);
 	SetElementNativeValues(e, 'ACBS\Flags', GetElementNativeValues(e, 'ACBS\Flags') or 128);
	  
		// The Base is added to the NewLevel and then divided by 1000
		// This is how this field works, for this setting 1000 = 1.0
		SetElementNativeValues(e, 'ACBS\Level Mult',(iNewLevel + iBase));

	// This changes Starting Hp, Stamina, and Magicka value of races.	

		// NPC initial health is usually (when not scaled to player) Offset + Starting health
		// This means if untouched, every NPC will have halved health values. 
		// To avoid initial very small values we change it.
		// Users may change this value if they want.
		iMult := 2;
				
	if Signature(e) = 'RACE' then
	
    	iHealth := GetElementNativeValues(e, 'DATA - DATA\Starting Health');
		iHealthPlus := iHealth / iMult;
		 
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

