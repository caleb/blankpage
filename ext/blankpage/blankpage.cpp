#include <rice/rice.hpp>
#include <rice/stl.hpp>

#include <opencv2/core/core.hpp>
#include <opencv2/features2d.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/imgproc.hpp>

#include <algorithm>
#include <iostream>
#include <queue>
#include <set>
#include <vector>

#define DEBUG false

using namespace cv;
using namespace std;
using namespace Rice;

bool is_whitepage(Mat im) {
 Mat new_image = Mat::zeros( im.size(), im.type() );

  double alpha = 1.25; /*< Simple contrast control */
  int beta = 0; /*< Simple brightness control */

  for( int y = 0; y < im.rows; y++ ) {
    for( int x = 0; x < im.cols; x++ ) {
      for( int c = 0; c < im.channels(); c++ ) {
        new_image.at<Vec3b>(y,x)[c] =
        saturate_cast<uchar>( alpha*im.at<Vec3b>(y,x)[c] + beta );
      }
    }
  }

  std::vector<KeyPoint> keypoints;

  SimpleBlobDetector::Params params;
  params.minThreshold = 10;
  params.maxThreshold = 200;
  params.filterByArea = true;
  params.minArea = 20;
  params.filterByCircularity = false;
  params.minCircularity = 1;
  params.filterByConvexity = false;
  params.minConvexity = 1;
  params.filterByInertia = true;
  params.minInertiaRatio = 0.01;

  Ptr<SimpleBlobDetector> detector = SimpleBlobDetector::create(params);
  detector->detect(new_image, keypoints);

  double blobs_ratio = (double)keypoints.size() / (1.0 * im.rows * im.cols);

  if (DEBUG) {
    cout << "Blobs Ratio: " << blobs_ratio << endl;
    cout << "We've detected " << keypoints.size() << " keypoints" << endl;
  }

  bool is_whitepage = false;

  if (blobs_ratio < 1E-6) {
    is_whitepage = true;
    if (DEBUG)
      cout << "This page is blank." << endl;
  }

  return is_whitepage;
}

bool is_blank_filename(std::string filename) {
  Mat im = imread(filename);
  return is_whitepage(im);
}

bool is_blank_bytes(std::string byte_string) {
  uchar* bytes = reinterpret_cast<uchar*>(byte_string.data());
  size_t length = byte_string.size();

  cv::Mat1b data(1, length, bytes);
  Mat im = imdecode(data, IMREAD_ANYCOLOR);
  return is_whitepage(im);
}

extern "C" void
Init_blankpage(void) {
  Module rb_mBlankpage = define_module("Blankpage");
  rb_mBlankpage.define_module_function("is_blank_filename?", &is_blank_filename);
  rb_mBlankpage.define_module_function("is_blank_bytes?", &is_blank_bytes);
}
