#include <Rcpp.h>
#include <algorithm>
using namespace Rcpp;

std::string stopwords(std::vector<std::string> x, std::vector<std::string> stwd) {

  std::string sentence;

  // For loop to remove stop words
  for (size_t i = 0; i < x.size(); ++i) {
    if (std::find(stwd.begin(), stwd.end(), x[i]) == stwd.end()) {
      sentence += x[i];
      sentence += " ";
    }
  }

  // Remove extra white space at the end of the sentence
  if (!sentence.empty()) {
    sentence.pop_back();
  }

  return sentence;
}

// [[Rcpp::export]]
std::vector<std::string> remove_stopword_cpp(std::list<std::vector<std::string>> x, std::vector<std::string> stwd){

  std::vector<std::string> sentences;

  // For loop to travel through the list
  for (auto i = x.begin(); i != x.end(); ++i){
    sentences.push_back(stopwords(*i,stwd));
  }

  return sentences;
}
