#!/bin/bash

# Usage: ./build.sh [layer_name] or ./build.sh (to build all)

LAYERS=("psycopg2-binary" "psycopg3-binary" "pymysql" "pyjwt" "python-jose")

mkdir -p dist

build_layer() {
    local layer_name=$1

    echo "Building layer: $layer_name"

    if [ ! -d "$layer_name" ]; then
        echo "ERROR: Directory $layer_name not found!"
        return 1
    fi

    cd "$layer_name"

    rm -f "${layer_name}-layer.zip"

    docker build --platform linux/amd64 -t "${layer_name}-layer" .

    CONTAINER_ID=$(docker create --platform linux/amd64 "${layer_name}-layer")
    docker cp "$CONTAINER_ID:/opt/${layer_name}-layer.zip" ./
    docker rm $CONTAINER_ID

    if [ -f "${layer_name}-layer.zip" ]; then
        echo "✓ Layer $layer_name built successfully!"
        mv "${layer_name}-layer.zip" "../dist/"
        echo "  → Saved to: dist/${layer_name}-layer.zip"
    else
        echo "✗ ERROR: Failed to create layer $layer_name!"
        cd ..
        return 1
    fi

    cd ..
}

build_all() {
    echo "Building all lambda layers..."

    for layer in "${LAYERS[@]}"; do
        if ! build_layer "$layer"; then
            echo "Failed to build layer: $layer"
            exit 1
        fi
        echo ""
    done

    echo "All layers built successfully!"
    echo "Output files in dist/ directory:"
    ls -la dist/
}

if [ $# -eq 0 ]; then
    build_all
elif [ $# -eq 1 ]; then
    layer_name=$1

    if [[ " ${LAYERS[*]} " =~ " ${layer_name} " ]]; then
        build_layer "$layer_name"
    else
        echo "ERROR: Layer '$layer_name' not found!"
        echo "Available layers: ${LAYERS[*]}"
        exit 1
    fi
else
    echo "Usage: $0 [layer_name]"
    echo "  - No arguments: builds all layers"
    echo "  - With layer_name: builds only the specified layer"
    echo ""
    echo "Available layers: ${LAYERS[*]}"
    exit 1
fi
