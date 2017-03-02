const APIUtil = require("./api_util.js");

class TweetCompose{
  constructor(el){
    this.form = $(el);
    this.form.find("input.submit").click(e => this.submit(e));
  }

  submit(e){
    e.preventDefault();
    let promise = APIUtil.createTweet(this.form.serializeJSON());
    promise.then((res) => console.log(res))
      .catch(() => console.log("No new tweet created!"));
  }

  handleSuccess() {
    //call clear inputs
    //re enable the form
    //add tweet to ul of tweets
    this.clearInput();
    $("form.tweet-compose:input").prop("disabled", false);
  }

  clearInput() {
    //clear form inputs
    this.form.find("textarea").text("");
  }
}
