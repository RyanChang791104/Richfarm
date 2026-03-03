#!/bin/bash
SOURCE_DIR="/Users/rychang/Desktop/Richfarm/Richfarm/Images"
DEST_DIR="/Users/rychang/Desktop/richfarm_ios/richfarm_ios/Assets.xcassets"

mkdir -p "$DEST_DIR"

for img in "$SOURCE_DIR"/*.jpg; do
    filename=$(basename "$img")
    name="${filename%.*}"
    
    asset_dir="$DEST_DIR/$name.imageset"
    mkdir -p "$asset_dir"
    
    cp "$img" "$asset_dir/"
    
    cat << JSON > "$asset_dir/Contents.json"
{
  "images" : [
    {
      "filename" : "$filename",
      "idiom" : "universal",
      "scale" : "1x"
    },
    {
      "idiom" : "universal",
      "scale" : "2x"
    },
    {
      "idiom" : "universal",
      "scale" : "3x"
    }
  ],
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
}
JSON
done

echo "Done copying images"
