# Jaccard Similarity Scorer for hashes and json

This is a small app to compare two json objects or hashes and return a number between 0 and 1 representing the similarity between the two objects. Identical objects are represented by 1 and completely different objects are represented by 0. This code was implemented using the Jaccard Similarity index algorithm. For nested objects I'm flattening the hashes so we can compare as unidimensional arrays.

The complexity for this implementation is O(n\*m).

## Running the specs

To run the specs you have to install the dependencies:

`bundle install`

and then

`bundle exec rspec`

## Testing with the sample files

I wrote a script to compare all sample files agains the master file. You just have to run this command:

`bundle exec ruby compare_files.rb`
