function userInformationHTML(user) {
  return `
        <h2>${user.name}
            <span class="small-name">
                (@<a href="${user.html_url}" target="_blank">${user.login}</a>)
            </span>
        </h2>
        <div class="gh-content">
            <div class="gh-avatar">
                <a href="${user.html_url}" target="_blank">
                    <img src="${user.avatar_url}" width="80" height="80" alt="${user.login}" />
                </a>
            </div>
            <p>Followers: ${user.followers} - Following ${user.following} <br> Repos: ${user.public_repos}</p>
        </div>`
}

function repoInformationHTML(repos) {
  if (repos.length == 0) {
    return `<div class="clearfix repo-list">No repos!</div>`
  }

  var listItemsHTML = repos.map(function (repo) {
    return `<li>
                    <a href="${repo.html_url}" target="_blank">${repo.name}</a>
                </li>`
  })

  return `<div class="clearfix repo-list">
                <p>
                    <strong>Repo List:</strong>
                </p>
                <ul>
                    ${listItemsHTML.join('\n')}
                </ul>
            </div>`
}

repoFollowersHTML = (followers) => {
  if (followers.length == 0) {
    return `<div class="clearfix repo-list">No followers!</div>`
  }
  var listItemsHTML = followers.map(function (follower) {
    return `<a href="#" onclick="$('#gh-username').val('${follower.login}');fetchGitHubInformation()" url="${follower.html_url}">${follower.login}</a> | `
  })
  //   document.getElementById('gh-username').value = this.text; fetchGitHubInformation()
  return `<div class="clearfix repo-list">
                <p>
                    <strong>Followers:</strong>
                </p>
                
                    ${listItemsHTML.join('\n')}
                
            </div>`
}

function fetchGitHubInformation(event) {
  $('#gh-user-data').html('')
  $('#gh-repo-data').html('')
  $('#gh-followers').html('')

  var username = $('#gh-username').val()
  if (!username) {
    $('#gh-user-data').html(`<h2>Please enter a GitHub username</h2>`)
    return
  }

  $('#gh-stats').html(`
    <img height="180em" src="https://github-readme-stats.vercel.app/api?username=${username}&show=reviews,discussions_started,discussions_answered,prs_merged,prs_merged_percentage"/>
    <br />
    <img height="180em" src="https://github-readme-stats.vercel.app/api/top-langs/?username=${username}&layout=compact&custom_title=Github Most Used Languages" />`)
  $('#gh-user-data').html(
    `<div id="loader">
            <img src="assets/css/loader.gif" alt="loading..." />
        </div>`
  )

  $.when(
    $.getJSON(`https://api.github.com/users/${username}`),
    $.getJSON(`https://api.github.com/users/${username}/repos`),
    $.getJSON(`https://api.github.com/users/${username}/following`)
  ).then(
    function (firstResponse, secondResponse, thirdResponse) {
      var userData = firstResponse[0]
      var repoData = secondResponse[0]
      var repoFollowers = thirdResponse[0]
      $('#gh-user-data').html(userInformationHTML(userData))
      $('#gh-repo-data').html(repoInformationHTML(repoData))
      $('#gh-followers').html(repoFollowersHTML(repoFollowers))
    },
    function (errorResponse) {
      if (errorResponse.status === 404) {
        $('#gh-user-data').html(`<h2>No info found for user ${username}</h2>`)
      } else if (errorResponse.status === 403) {
        var resetTime = new Date(
          errorResponse.getResponseHeader('X-RateLimit-Reset') * 1000
        )
        $('#gh-user-data').html(
          `<h4>Too many requests, please wait until ${resetTime.toLocaleTimeString()}</h4>`
        )
      } else {
        console.log(errorResponse)
        $('#gh-user-data').html(
          `<h2>Error: ${errorResponse.responseJSON.message}</h2>`
        )
      }
    }
  )
}

$(document).ready(fetchGitHubInformation)
