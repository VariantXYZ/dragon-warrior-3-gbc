; Game specific
DEF C_CurrentBank        EQU $4000


DEF H_RegJoyp            EQU $ff00
DEF H_RegSB              EQU $ff01
DEF H_RegSC              EQU $ff02
DEF H_RegDIV             EQU $ff04
DEF H_RegTIMA            EQU $ff05
DEF H_RegTMA             EQU $ff06
DEF H_RegTAC             EQU $ff07
DEF H_RegIF              EQU $ff0f
DEF H_RegNR10            EQU $ff10
DEF H_RegNR11            EQU $ff11
DEF H_RegNR12            EQU $ff12
DEF H_RegNR13            EQU $ff13
DEF H_RegNR14            EQU $ff14
DEF H_RegNR21            EQU $ff16
DEF H_RegNR22            EQU $ff17
DEF H_RegNR23            EQU $ff18
DEF H_RegNR24            EQU $ff19
DEF H_RegNR30            EQU $ff1a
DEF H_RegNR31            EQU $ff1b
DEF H_RegNR32            EQU $ff1c
DEF H_RegNR33            EQU $ff1d
DEF H_RegNR34            EQU $ff1e
DEF H_RegNR41            EQU $ff20
DEF H_RegNR42            EQU $ff21
DEF H_RegNR43            EQU $ff22
DEF H_RegNR44            EQU $ff23
DEF H_RegNR50            EQU $ff24
DEF H_RegNR51            EQU $ff25
DEF H_RegNR52            EQU $ff26
DEF H_RegLCDC            EQU $ff40
DEF H_LCDStat            EQU $ff41
DEF H_RegSCY             EQU $ff42
DEF H_RegSCX             EQU $ff43
DEF H_RegLY              EQU $ff44
DEF H_RegLYC             EQU $ff45
DEF H_RegDMA             EQU $ff46
DEF H_RegBGP             EQU $ff47
DEF H_RegOBP0            EQU $ff48
DEF H_RegOBP1            EQU $ff49
DEF H_RegWY              EQU $ff4a
DEF H_RegWX              EQU $ff4b
DEF H_RegKEY1            EQU $ff4d
DEF H_RegVBK             EQU $ff4f
DEF H_RegHDMA1           EQU $ff51
DEF H_RegHDMA2           EQU $ff52
DEF H_RegHDMA3           EQU $ff53
DEF H_RegHDMA4           EQU $ff54
DEF H_RegHDMA5           EQU $ff55
DEF H_RegRP              EQU $ff56
DEF H_RegBGPI            EQU $ff68
DEF H_RegBGPD            EQU $ff69
DEF H_RegOBPI            EQU $ff6a
DEF H_RegOBPD            EQU $ff6b
DEF H_RegSVBK            EQU $ff70
DEF H_RegIE              EQU $ffff

DEF H_PushOAM            EQU $ff80

; Joypad
DEF H_JPInputHeldDown    EQU $ff8c
DEF H_JPInputChanged     EQU $ff8d

DEF H_VBlankCompleted    EQU $ff92

DEF H_SoundEffect        EQU $ffa1

DEF M_JPInputA           EQU $1
DEF M_JPInputB           EQU $2
DEF M_JPInputSelect      EQU $4
DEF M_JPInputStart       EQU $8
DEF M_JPInputRight       EQU $10
DEF M_JPInputLeft        EQU $20
DEF M_JPInputUp          EQU $40
DEF M_JPInputDown        EQU $80

DEF X_MBC5SRAMEnable     EQU $0000
DEF X_MBC5ROMBankLow     EQU $2000
DEF X_MBC5ROMBankHigh    EQU $3000
DEF X_MBC5SRAMBank       EQU $4000