

import os
from pysysml2.modeling import Model


in_f = "./examples/updated_test/beagleplay_set1.sysml2"
# in_f = "./examples/models/model_test_1.sysml2"
model = Model() # Create Model object
model.from_sysml2_file(in_f) # Parse the textual model

