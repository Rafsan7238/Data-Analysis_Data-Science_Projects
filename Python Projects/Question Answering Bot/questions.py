import nltk
import sys
import os
import string
import math
nltk.download('stopwords')

FILE_MATCHES = 1
SENTENCE_MATCHES = 1


def main():

    # Check command-line arguments
    if len(sys.argv) != 2:
        sys.exit("Usage: python questions.py corpus")

    # Calculate IDF values across files
    files = load_files(sys.argv[1])
    file_words = {
        filename: tokenize(files[filename])
        for filename in files
    }
    file_idfs = compute_idfs(file_words)

    # Prompt user for query
    query = set(tokenize(input("Query: ")))

    # Determine top file matches according to TF-IDF
    filenames = top_files(query, file_words, file_idfs, n=FILE_MATCHES)

    # Extract sentences from top files
    sentences = dict()
    for filename in filenames:
        for passage in files[filename].split("\n"):
            for sentence in nltk.sent_tokenize(passage):
                tokens = tokenize(sentence)
                if tokens:
                    sentences[sentence] = tokens

    # Compute IDF values across sentences
    idfs = compute_idfs(sentences)

    # Determine top sentence matches
    matches = top_sentences(query, sentences, idfs, n=SENTENCE_MATCHES)
    for match in matches:
        print(match)


def load_files(directory):
    """
    Given a directory name, return a dictionary mapping the filename of each
    `.txt` file inside that directory to the file's contents as a string.
    """
    
    files = dict()

    # traverse through all the files in the corpus
    for filename in os.listdir(directory):
        file_pathname = os.path.join(directory, filename)

        # read the file add to files dict if it is a txt file
        if os.path.isfile(file_pathname) and filename.endswith(".txt"):
            file = open(file_pathname, "r")
            files[filename] = file.read()
            file.close()

    return files


def tokenize(document):
    """
    Given a document (represented as a string), return a list of all of the
    words in that document, in order.

    Process document by coverting all words to lowercase, and removing any
    punctuation or English stopwords.
    """
    
    word_list = []

    document = document.lower()
    words = nltk.word_tokenize(document)
    stopwords = nltk.corpus.stopwords.words("english")
    punctuations = string.punctuation

    for word in words:
        if word not in stopwords and word not in punctuations:
            word_list.append(word)

    return word_list


def compute_idfs(documents):
    """
    Given a dictionary of `documents` that maps names of documents to a list
    of words, return a dictionary that maps words to their IDF values.

    Any word that appears in at least one of the documents should be in the
    resulting dictionary.
    """
    
    idfs = dict()
    total_documents = len(documents)
    words = set()

    for document in documents.values():
        for word in document:
            words.add(word)

    for word in words:
        docs_containing_word = 0

        for document in documents.values():
            if word in document:
                docs_containing_word = docs_containing_word + 1
        
        idf_value = math.log(total_documents / docs_containing_word)
        idfs[word] = idf_value

    return idfs


def top_files(query, files, idfs, n):
    """
    Given a `query` (a set of words), `files` (a dictionary mapping names of
    files to a list of their words), and `idfs` (a dictionary mapping words
    to their IDF values), return a list of the filenames of the the `n` top
    files that match the query, ranked according to tf-idf.
    """
    
    tf_idfs = dict()

    for file in files:
        tf_idfs[file] = 0

        for word in query:
            tf_idf = files[file].count(word) * idfs[word]
            tf_idfs[file] += tf_idf

    ranked_file_list = sorted(tf_idfs.items(), key=lambda x: x[1], reverse=True)
    ranked_file_list = [file[0] for file in ranked_file_list]

    return ranked_file_list[:n]


def top_sentences(query, sentences, idfs, n):
    """
    Given a `query` (a set of words), `sentences` (a dictionary mapping
    sentences to a list of their words), and `idfs` (a dictionary mapping words
    to their IDF values), return a list of the `n` top sentences that match
    the query, ranked according to idf. If there are ties, preference should
    be given to sentences that have a higher query term density.
    """
    
    ranked_list = []

    for sentence in sentences:
        sentence_scores = [sentence, 0, 0]

        for word in query:
            if word in sentences[sentence]:

                sentence_scores[1] = sentence_scores[1] + idfs[word]

                sentence_scores[2] = sentence_scores[2] + (sentences[sentence].count(word) / len(sentences[sentence]))

        ranked_list.append(sentence_scores)

    ranked_sentence_list = sorted(ranked_list, key=lambda x: (x[1], x[2]), reverse=True)
    ranked_sentence_list = [sentence for sentence, matching_word, query_den in ranked_sentence_list]

    return ranked_sentence_list[:n]


if __name__ == "__main__":
    main()
