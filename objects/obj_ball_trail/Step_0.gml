image_alpha -= alpha_decay;
if (image_alpha <= 0)
	instance_destroy();