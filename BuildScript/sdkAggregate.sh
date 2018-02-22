
#!/bin/bash


# = 前后不能有空格要不然会出错
echo "run sdkAggregate script begin"

script_dir=${SRCROOT%/*}

target_name=${TARGET_NAME}
# framework的名称
target_name=RXSDK
# framework的扩展名
framework_ext=.framework

framework_file_name=$target_name$framework_ext

# 编译的目录
# /Users/rush.d.xzj/Library/Developer/Xcode/DerivedData/HDRSDK-dhijegzprahyjqhahvwrkuecodnn/Build/Products/Release-iphoneos
# 去掉最后一个反斜杠后面的内容
build_dir=${CONFIGURATION_BUILD_DIR%/*}
# 编译的模式Debug Release
build_mode=${CONFIGURATION}
build_framework_path_iphoneos_for_framework=$build_dir/$build_mode-iphoneos/$framework_file_name
build_framework_merge_path_iphoneos=$build_framework_path_iphoneos_for_framework/$target_name
build_framework_merge_path_iphonesimulator=$build_dir/$build_mode-iphonesimulator/$framework_file_name/$target_name


echo $build_dir
echo $build_mode
echo $build_framework_merge_path_iphoneos
echo $build_framework_merge_path_iphonesimulator


sdk_home_dir=${SRCROOT%/*}

sdk_mid_build_framework_merge_path_tmp_dir=$sdk_home_dir/tmp
echo "中间临时产生的目录:$sdk_mid_build_framework_merge_path_tmp_dir"
# 判断文件夹是否存在:
if [ ! -d "$sdk_mid_build_framework_merge_path_tmp_dir" ]; then
	echo "dir not found need to mkdir"
 	mkdir $sdk_mid_build_framework_merge_path_tmp_dir
fi

sdk_mid_build_framework_merge_path_dir=$sdk_mid_build_framework_merge_path_tmp_dir/sdk_mid_build
echo "中间临时产生的目录:$sdk_mid_build_framework_merge_path_dir"
# 判断文件夹是否存在:
if [ ! -d "$sdk_mid_build_framework_merge_path_dir" ]; then
	echo "dir not found need to mkdir"
 	mkdir $sdk_mid_build_framework_merge_path_dir
fi

sdk_mid_build_framework_merge_path=$sdk_mid_build_framework_merge_path_dir/$target_name

# 先删除文件
rm -rf $sdk_mid_build_framework_merge_path

echo "os需要合并的文件:$build_framework_merge_path_iphoneos"
echo "simulator需要合并的文件:$build_framework_merge_path_iphonesimulator"
echo "合并后的文件:$sdk_mid_build_framework_merge_path"

# 把os的和simulator的合并成一个
lipo -create "$build_framework_merge_path_iphoneos" "$build_framework_merge_path_iphonesimulator" -output "$sdk_mid_build_framework_merge_path"



sdk_release_output_framework_path_dir=$sdk_mid_build_framework_merge_path_tmp_dir/sdk_release_output
echo "中间临时产生的目录:$sdk_release_output_framework_path_dir"
# 判断文件夹是否存在:
if [ ! -d "$sdk_release_output_framework_path_dir" ]; then
	echo "dir not found need to mkdir"
 	mkdir $sdk_release_output_framework_path_dir
fi

sdk_release_output_framework_path=$sdk_release_output_framework_path_dir/$framework_file_name
echo "framework的生成后的路径:$sdk_release_output_framework_path"
# 先删除这个framework
rm -rf $sdk_release_output_framework_path
# 复制os中的framework到刚刚的framework路径下
cp -a $build_framework_path_iphoneos_for_framework $sdk_release_output_framework_path

sdk_release_output_framework_path_file=$sdk_release_output_framework_path/$target_name
echo "需要被替换的文件路径:$sdk_release_output_framework_path_file"
# 先删除此文件
rm -rf $sdk_release_output_framework_path_file
# 再复制
cp -a $sdk_mid_build_framework_merge_path $sdk_release_output_framework_path_file

# 需要copy相关文件到相关目录下, 放到framework的git文件下:
sdk_parent_path_dir=${script_dir%/*}
echo "sdk parent path:$sdk_parent_path_dir"
sdk_path_dir=${sdk_parent_path_dir}/RXSDK-iOS/RXSDK
echo "sdk path:$sdk_path_dir"
sdk_framework_file=$sdk_path_dir/$framework_file_name
echo "sdk framework file:$sdk_framework_file"
# 先删除此文件
rm -rf $sdk_framework_file
# 复制framework文件夹
cp -a $sdk_release_output_framework_path $sdk_framework_file


# 最后删除tmp文件夹
rm -rf $sdk_mid_build_framework_merge_path_tmp_dir




echo "run sdkAggregate script end"




