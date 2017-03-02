const APIUtil = require("./api_util.js");

class FollowToggle{
  constructor(el) {
    this.button = $(el);
    this.userId = this.button.attr('data-user-id');
    if (this.button.attr("data-initial-follow-state") === "true") {
      this.followState = "followed";
    }
    else {
      this.followState = "unfollowed";
    }
    this.render();

    this.button.on("click", (e) => this.handleClick(e));
  }

  render() {
    if (this.followState === "followed") {
      this.button.text("Unfollow!");
    }
    else {
      this.button.text("Follow!");
    }
  }

  handleClick(e) {
    e.preventDefault();
    this.button.prop("disabled", true);
    let promise;
    if (this.followState === "followed") {
      promise = APIUtil.unfollowUser(this.userId);
    }
    else {
      promise = APIUtil.followUser(this.userId);
    }
    promise.then(() => this.switchFollow())
      .then(() => this.render())
      .then(() => this.button.prop("disabled", false))
      .fail(() => console.log("It doesn't work"));
  }

  switchFollow() {
    if (this.followState === "followed") {
      this.followState = "unfollowed";
      this.button.attr("data-initial-follow-state", false);
    }
    else {
      this.followState = "followed";
      this.button.attr("data-initial-follow-state", true);
    }
  }
}

module.exports = FollowToggle;
