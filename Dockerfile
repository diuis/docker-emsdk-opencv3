FROM diuis/docker-emsdk-installed:v1.0.1

ARG OPENCV_ARCHIVE=https://github.com/opencv/opencv/tarball/3.4.5

USER appuser
RUN wget -nv $OPENCV_ARCHIVE -O /home/appuser/opencv.tar && \
    mkdir /home/appuser/opencv && \
    tar xf /home/appuser/opencv.tar -C /home/appuser/opencv --strip-components 1 && \
    rm /home/appuser/opencv.tar && \
    cd /home/appuser/opencv && \
    mkdir build && \
    cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE -G "Unix Makefiles" \
    -D CMAKE_CXX_FLAGS_RELEASE=-DNDEBUG -O3 \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D BUILD_SHARED_LIBS=ON \
    -D WITH_TBB=OFF \
    -D WITH_V4L=OFF \
    -D WITH_QT=OFF \
    -D WITH_TIFF=OFF \
    -D WITH_OPENGL=OFF \
    -D WITH_OPENEXR=OFF \
    -D WITH_WEBP=OFF \
    -D BUILD_TESTS=OFF \
    -D BUILD_PERF_TESTS=OFF \
    -D WITH_1394=OFF \
    -D WITH_VTK=OFF \
    -D WITH_CUDA=OFF \
    -D WITH_CUFFT=OFF \
    -D WITH_CUBLAS=OFF \
    -D WITH_NVCUVID=OFF \
    -D WITH_EIGEN=OFF \
    -D WITH_FFMPEG=ON \
    -D BUILD_ZLIB=ON \
    -D BUILD_opencv_apps=OFF \
    -D BUILD_opencv_calib3d=ON \
    -D BUILD_opencv_dnn=OFF \
    -D BUILD_opencv_features2d=ON \
    -D BUILD_opencv_flann=OFF \
    -D BUILD_opencv_ml=OFF \
    -D BUILD_opencv_photo=OFF \
    -D BUILD_opencv_imgcodecs=ON \
    -D BUILD_opencv_shape=OFF \
    -D BUILD_opencv_videoio=ON \
    -D BUILD_opencv_videostab=OFF \
    -D BUILD_opencv_highgui=ON \
    -D BUILD_opencv_superres=OFF \
    -D BUILD_opencv_stitching=OFF \
    -D BUILD_opencv_java=OFF \
    -D BUILD_opencv_js=OFF \
    -D BUILD_opencv_python2=OFF \
    -D BUILD_opencv_python3=OFF \
    -D BUILD_java_bindings_generator=OFF \
    -D BUILD_python_bindings_generator=OFF \
    -D BUILD_EXAMPLES=OFF \
    -D BUILD_PACKAGE=OFF .. && \
    make -j4

USER root
RUN cd /home/appuser/opencv/build \
    && make install \
    && ldconfig
