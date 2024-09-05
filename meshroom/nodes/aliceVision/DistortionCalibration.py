__version__ = '5.0'

from meshroom.core import desc
from meshroom.core.utils import VERBOSE_LEVEL


class DistortionCalibration(desc.AVCommandLineNode):
    commandLine = 'aliceVision_distortionCalibration {allParams}'
    size = desc.DynamicNodeSize('input')

    category = 'Other'
    documentation = '''
Calibration of a camera/lens couple distortion using a full screen checkerboard.
'''

    inputs = [
        desc.File(
            name="input",
            label="Input SfMData",
            description="SfMData file.",
            value="",
            invalidate=True,
        ),
        desc.File(
            name="checkerboards",
            label="Checkerboards Folder",
            description="Folder containing checkerboard JSON files.",
            value="",
            invalidate=True,
        ),
        desc.ChoiceParam(
            name="undistortionModelName",
            label="Undistortion Model",
            description="model used to estimate undistortion.",
            value="3deanamorphic4",
            values=["3deanamorphic4", "3declassicld", "3deradial4"],
            exclusive=True,
            invalidate=True,
        ),
        desc.BoolParam(
            name="handleSqueeze",
            label="Handle Squeeze",
            description="Estimate squeeze.",
            value=True,
            invalidate=True,
        ),
        desc.BoolParam(
            name="isDesqueezed",
            label="Is Desqueezed",
            description="True if the input image is already desqueezed.",
            value=False,
            invalidate=True,
        ),
        desc.ChoiceParam(
            name="verboseLevel",
            label="Verbose Level",
            description="Verbosity level (fatal, error, warning, info, debug, trace).",
            values=VERBOSE_LEVEL,
            value="info",
            exclusive=True,
            invalidate=False,
        ),
    ]

    outputs = [
        desc.File(
            name="output",
            label="SfMData File",
            description="Path to the output SfMData file.",
            value=desc.Node.internalFolder + "sfmData.sfm",
            invalidate=False,
        ),
    ]
