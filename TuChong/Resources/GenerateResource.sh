#!/bin/sh
# is used to provide the input file, template and output file to generate the swift code for assets, the same has been repeated for strings, fonts and colours above.
RSROOT=$SRCROOT/TuChong/Resources

"$PODS_ROOT/SwiftGen/bin/swiftgen" \
xcassets -t swift4 "$RSROOT/Assets.xcassets" \
--output "$RSROOT/Assets.swift"

"$PODS_ROOT/SwiftGen/bin/swiftgen" \
strings -t structured-swift4 "$RSROOT/Localizable.strings" \
--output "$RSROOT/Localize.swift"

"$PODS_ROOT/SwiftGen/bin/swiftgen" \
colors -t swift4 "$RSROOT/Colors.json" \
--output "$RSROOT/Colors.swift"

"$PODS_ROOT/SwiftGen/bin/swiftgen" \
fonts -t swift4 "$RSROOT/Fonts" \
--output "$RSROOT/Fonts.swift"
