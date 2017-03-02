const APIUtil = require("./api_util.js");
const FollowToggle = require("./follow_toggle.js");

class UsersSearch {
  constructor(el) {
    this.nav = $(el);
    this.input = this.nav.find("input");
    this.list = this.nav.find("ul.users");

    this.input.change(() => this.handleInput(this.input.val()));
  }

  handleInput(val) {
    let promise = APIUtil.searchUsers(val);
    promise.then(res => this.renderResults(res))
            .fail(() => console.log("It failed!"));
  }

  renderResults(userList) {
    this.list.empty();
    userList.forEach((user) => {
      let button = `<button class="follow-toggle" type="button" data-user-id="${user.id}" data-initial-follow-state="${user.followed}"></button>`;
      this.list.append(`<li>${user.username}</li>`)
                .append(button);
      new FollowToggle($("button.follow-toggle:last-child")[0]);
    });
  }
}

module.exports = UsersSearch;
