JsOsaDAS1.001.00bplist00�Vscript_	�/* Crop a screenshot to show only the screen's frontmost window. 
 *
 * Usage: Run the script in the background, either by using an app such as 
 * FastScripts or by creating a Shortcut. The script creates both the 
 * complete screenshot and the cropped version.
 */

/*-----Initialization---------------------------------------------------------*/
const app = Application.currentApplication();
app.includeStandardAdditions = true;

const finder = Application('Finder');
const se = Application('System Events');

/*-----Main-------------------------------------------------------------------*/

let frontProc = se.applicationProcesses.whose({frontmost: true})[0];
const geom = makeGeometryString(frontProc);
const ssCountInitial = countScreenShots();
takeScreenShot();
awaitNewScreehShot(ssCountInitial);
ss = getNewScreenShotName();
ssNew = moveScreenShotToTempFolder(ss);
sscropped = cropScreenShot(ssNew, geom);
sscropped

/*-----Functions--------------------------------------------------------------*/
function cropScreenShot(ssNew, geom) {
	return app.doShellScript("cd $HOME/tmp; " + 
		"f=" + ssNew + "; f1=${f/.png/-cropped.png}; " + 
		"/usr/local/bin/convert $f -crop " + geom + " $f1; open $f1; echo $f1");
}

function moveScreenShotToTempFolder(ss) {
	return app.doShellScript("cd $HOME; " + 
		"f=`echo '" + ss + "' | tr ' ' '_'`; " +
		"f1=Screenshot_`date '+%Y-%m-%d-%H%M%S'`.png; " + 
		'mv "./Desktop/${f//_/ }" ./tmp/$f1; open ./tmp; echo $f1')
}

function getNewScreenShotName() {	// get name of recently added screenshot
	return app.doShellScript( "cd $HOME/desktop; " + 
		"ls | grep 'Screenshot 2' | tail -n 1" );
}

function awaitNewScreehShot(ssCountInitial) {
	while(countScreenShots() == ssCountInitial) { delay(0.1) }
}

function makeGeometryString(frontProc) {
	// The dimensions computed by the script all need to be doubled: the script
	// assumes a pixel density of 72 dpi, but my (Retina) screen actually uses 
	// a density of 144 dpi.
	const w = frontProc.windows[0];
	const wsize = w.size();
	const wpos = w.position();
	const geom = (2 * wsize[0]).toString() + 'x' + (2 * wsize[1]).toString() + 
		'+' + (2 * wpos[0]).toString() + '+' + (2 * wpos[1]).toString();
	return geom;
}

function takeScreenShot(){
	// 'using: "shift down" doesn't work; use following instead of 
	// '{using: ["shift down", "command down"]}':
	se.keystroke("#", {using: "command down"});
}

function countScreenShots() {
	return app.doShellScript(
		"cd $HOME/Desktop; ls | grep 'Screenshot 2' | wc -l"
	)
}
                              	�jscr  ��ޭ