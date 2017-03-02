/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;
/******/
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	const FollowToggle = __webpack_require__(1);
	const UsersSearch = __webpack_require__(3);
	
	$(() => {
	  $("button.follow-toggle").each((i, el) => {
	    new FollowToggle(el);
	  });
	  $("nav.users-search").each((i, el) => {
	    new UsersSearch(el);
	  });
	});


/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

	const APIUtil = __webpack_require__(2);
	
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


/***/ },
/* 2 */
/***/ function(module, exports) {

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


/***/ },
/* 3 */
/***/ function(module, exports, __webpack_require__) {

	const APIUtil = __webpack_require__(2);
	const FollowToggle = __webpack_require__(1);
	
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


/***/ }
/******/ ]);
//# sourceMappingURL=bundle.js.map