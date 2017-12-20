# Image Matting
## Description

This package contains the major source code of a demo for learning based digital image matting technique.
## Content

### GrabCut Code using python
  
Segment the foreground and background roughly

### Trimap Generation Code using matlab

Generate Trimap with the result of GrabCut Code

### Image Matting Code using matlab

Compute the alpha matte with the original rgb image and trimap, so we can segment the foreground precisely.

## Usage

**1. run GrabCut code**

```
python grabcut.py Original_resize.png
```

**2. run getTrimap.m**
- choose image from folder: originalMask

**3. run imageMatting.m**
- choose original image: Original_resize.png 
- choose trimap from folder: trimapOutput
- choose background image from folder: background
