function medianfilt
  I=imread("brainimg2.jpg");
  imshow(I);
  K=medfilt2(I);
  title("after medfilt");
  imshow(K);
  endfunction