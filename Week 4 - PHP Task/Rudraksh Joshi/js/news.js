// api key 8c24b088b7ac4bc08c1665cee2502994

categories = ["business", "technology", "entertainment", "sports", "science"];

random_category = Math.trunc(Math.random() * 4);

// console.log(random_category);
$.ajax({
  url: `https://newsapi.org/v2/top-headlines?category=${categories[random_category]}&pageSize=4&language=en&apiKey=8c24b088b7ac4bc08c1665cee2502994`,
  type: "GET",
  success: function (response) {
    // console.log(response);
    const articles = response.articles;
    articles.forEach((article) => {
      const source = article.source.name;
      const author = article.author;
      const title = article.title;
      const description = article.description;
      const url = article.url;
      const urlToImage = article.urlToImage;
      //   console.log(source);
      //   console.log(source);
      //   console.log(author);
      //   console.log(title);
      //   console.log(description);
      //   console.log(url);
      //   console.log(urlToImage);
      renderNews(source, author, title, description, url, urlToImage);
    });
  },
  error: function (error) {
    console.log(error);
  },
});

function renderNews(source, author, title, description, url, urlToImage) {
  //   console.log("in render news");
  const html = ` <div class="card mb-2 mt-4 py-4" style="width: 18rem">
${
  urlToImage == ""
    ? "<hr>"
    : `<img
src="${urlToImage}"
class="card-img-top"
/>`
}

<div class="card-body">
${author == "" ? "" : `<h5 class="card-title fw-bold"> ${author} </h5>`}
  
${title == "" ? "" : ` <h5 class="card-title"> ${title}</h5>`}
${source == "" ? "" : `  <h2 class="fs-6 text-secondary">Source ${source}</h2>`}
${
  description == ""
    ? ""
    : ` <p class="card-text">
  ${description}
  </p>`
}
  
  ${url == "" ? "" : `<a href="${url}" class="card-link">${url}</a>`}

</div>
</div>`;
  $("#newsRow").append(html);
}
