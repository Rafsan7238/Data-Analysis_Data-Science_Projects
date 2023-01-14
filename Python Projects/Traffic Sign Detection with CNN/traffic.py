import cv2
import numpy as np
import os
import sys
import tensorflow as tf

from sklearn.model_selection import train_test_split

EPOCHS = 10
IMG_WIDTH = 30
IMG_HEIGHT = 30
NUM_CATEGORIES = 43
TEST_SIZE = 0.4


def main():

    # Check command-line arguments
    if len(sys.argv) not in [2, 3]:
        sys.exit("Usage: python traffic.py data_directory [model.h5]")

    # Get image arrays and labels for all image files
    images, labels = load_data(sys.argv[1])

    # Split data into training and testing sets
    labels = tf.keras.utils.to_categorical(labels)
    x_train, x_test, y_train, y_test = train_test_split(
        np.array(images), np.array(labels), test_size=TEST_SIZE
    )

    # Get a compiled neural network
    model = get_model()

    # Fit model on training data
    model.fit(x_train, y_train, epochs=EPOCHS)

    # Evaluate neural network performance
    model.evaluate(x_test,  y_test, verbose=2)

    # Save model to file
    if len(sys.argv) == 3:
        filename = sys.argv[2]
        model.save(filename)
        print(f"Model saved to {filename}.")


def load_data(data_dir):
    """
    Load image data from directory `data_dir`.

    Assume `data_dir` has one directory named after each category, numbered
    0 through NUM_CATEGORIES - 1. Inside each category directory will be some
    number of image files.

    Return tuple `(images, labels)`. `images` should be a list of all
    the images in the data directory, where each image is formatted as a
    numpy ndarray with dimensions IMG_WIDTH x IMG_HEIGHT x 3. `labels` should
    be a list of integer labels, representing the categories for each of the
    corresponding `images`.
    """
    
    # initialise the images and labels list to be returned
    images = []
    labels = []

    # loop through all the folders in data_dir and print the folder data is being extracted from
    for directory in os.listdir(data_dir):
        directory_pathname = os.path.join(data_dir, directory)

        if os.path.isdir(directory_pathname):
            print(f"Data is being loaded from {directory_pathname}...")

            # loop through all the files in each folder, append the images as ndarray to images list with revised height and width
            # append the folder name as labels in the labels list
            # if there's an exception, print an error

            for file in os.listdir(directory_pathname):
                try:
                    img = cv2.imread(os.path.join(directory_pathname, file))
                    img = cv2.resize(img, (IMG_WIDTH, IMG_HEIGHT))

                    images.append(img)
                    labels.append(int(directory))

                except Exception as ex:
                    print(f"A problem is there in {file}")

    return (images, labels)


def get_model():
    """
    Returns a compiled convolutional neural network model. Assume that the
    `input_shape` of the first layer is `(IMG_WIDTH, IMG_HEIGHT, 3)`.
    The output layer should have `NUM_CATEGORIES` units, one for each category.
    """
    
    # build a CNN
    model = tf.keras.models.Sequential([

        # add a convolutional layer to learn 48 filters using a 3x3 kernel and relu activation function
        tf.keras.layers.Conv2D(32, (3, 3), activation="relu", input_shape=(IMG_WIDTH, IMG_HEIGHT, 3)),

        # add a max pooling layer using 2x2 pool size
        tf.keras.layers.MaxPooling2D(pool_size=(2, 2)),

         # add a convolutional layer to learn 48 filters using a 3x3 kernel and relu activation function
        tf.keras.layers.Conv2D(48, (3, 3), activation="relu", input_shape=(IMG_WIDTH, IMG_HEIGHT, 3)),

        # flatten the units
        tf.keras.layers.Flatten(),

        # add a hidden layer with 128 nodes and 0.5 dropout
        tf.keras.layers.Dense(128, activation="relu"),
        tf.keras.layers.Dropout(0.2),

        # add an output layer of 43 nodes with softmax activation function
        tf.keras.layers.Dense(NUM_CATEGORIES, activation="softmax")

    ])

    # train the CNN
    model.compile(

        optimizer="adam",
        loss="categorical_crossentropy",
        metrics=["accuracy"]

    )

    return model


if __name__ == "__main__":
    main()
