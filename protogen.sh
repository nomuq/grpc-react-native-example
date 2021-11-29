# protoc -I=proto --proto_path=proto --js_out=import_style=commonjs:echo echo.proto

# remove echo folder and create new one
rm -rf echo
mkdir echo

# grpc_tools_node_protoc -I=proto --proto_path=proto --js_out=import_style=commonjs,binary:echo \
#    --grpc_out=grpc_js:echo \
#    --plugin=protoc-gen-grpc=`which grpc_tools_node_protoc_plugin` \
#     echo.proto

# protoc \
#     --plugin=protoc-gen-ts=./node_modules/.bin/protoc-gen-ts \
#     --ts_out=echo \
#     -I ./proto \
#     echo.proto

protoc --proto_path=proto --go_out=echo --go_opt=paths=source_relative \
    --go-grpc_out=echo --go-grpc_opt=paths=source_relative \
    echo.proto

protoc -I=proto --proto_path=proto --js_out=import_style=commonjs:echo \
  --grpc-web_out=import_style=commonjs+dts,mode=grpcwebtext:echo \
    echo.proto