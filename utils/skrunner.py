import art
import sys
import os
import shutil

BARBARIANTHEULTIMATEWARRIORP1_HOME = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BARBARIANTHEULTIMATEWARRIORP1_SKOOL = '{}/sources/barbariantheultimatewarriorp1.skool'.format(BARBARIANTHEULTIMATEWARRIORP1_HOME)

SKOOLKIT_HOME = os.environ.get('SKOOLKIT_HOME') or os.path.normpath(
    os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'skoolkit-9.6'))
SKOOLKIT_TOOLS = "{}/tools".format(SKOOLKIT_HOME)
if SKOOLKIT_HOME:
    if not os.path.isdir(SKOOLKIT_HOME):
        sys.stderr.write('SKOOLKIT_HOME={}: directory not found\n'.format(SKOOLKIT_HOME))
        sys.exit(1)
    sys.path.insert(0, SKOOLKIT_HOME)
    from skoolkit import skool2asm, skool2html
else:
    try:
        from skoolkit import skool2asm, skool2html
    except ImportError:
        sys.stderr.write('Error: SKOOLKIT_HOME is not set, and SkoolKit is not installed\n')
        sys.exit(1)

sys.stderr.write("Found SkoolKit in {}\n".format(skool2html.PACKAGE_DIR))

def run_skool2asm():
    skool2asm.main(sys.argv[1:] + [BARBARIANTHEULTIMATEWARRIORP1_SKOOL])

def run_skool2html():
	art.tprint("barbariantheultimatewarriorp1")
	common = [
		'-c', 'Config/InitModule=' + SKOOLKIT_TOOLS + ':publish',
		'-d', BARBARIANTHEULTIMATEWARRIORP1_HOME + '/build',
	]
	hex_opts = ['-H', '-c', 'Config/GameDir=.', '--var', 'pub=2']
	dec_opts = ['-D', '-c', 'Config/GameDir=dec', '--var', 'pub=4']
	skool2html.main(common + hex_opts + sys.argv[1:] + [BARBARIANTHEULTIMATEWARRIORP1_SKOOL])
	skool2html.main(common + dec_opts + sys.argv[1:] + [BARBARIANTHEULTIMATEWARRIORP1_SKOOL])

	dec_build = BARBARIANTHEULTIMATEWARRIORP1_HOME + '/build/html/dec'
	for folder in ['assets', 'audio']:
		path = os.path.join(dec_build, folder)
		if os.path.exists(path):
        		shutil.rmtree(path)