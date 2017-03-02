const APIUtil = {
  followUser: id => (
    $.ajax({
      url: `${id}/follow`,
      dataType: "json",
      method: "POST"
    })
  ),

  unfollowUser: id => (
    $.ajax({
      url: `${id}/follow`,
      dataType: "json",
      method: "DELETE"
    })
  ),

  searchUsers: (queryVal, success) => (
    $.ajax({
      url: "/users/search",
      dataType: "json",
      method: "GET",
      data: {
        query: queryVal
      }
    })
  ),

  createTweet: (data) => {
    $("form.tweet-compose:input").prop("disabled", true);
    console.log(data);
    return $.ajax({
      url: "tweets",
      dataType: "json",
      method: "POST",
      data
    });
  }
};

module.exports = APIUtil;
