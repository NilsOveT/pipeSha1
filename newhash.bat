@mode COM8 BAUD=115200 PARITY=n DATA=8
REM echo "" > COM8
echo root > COM8
timeout 2 /NOBREAK > nul
echo ./sendhash > COM8
timeout 2 /NOBREAK
echo 6216f8a7 > COM8
timeout 4 /NOBREAK
echo 5fd5bb3d > COM8
timeout 4 /NOBREAK
echo 5f22b6f9 > COM8
timeout 4 /NOBREAK
echo 958cdede > COM8
timeout 4 /NOBREAK
echo 3fc086c2 > COM8
timeout 4 /NOBREAK
type COM8
