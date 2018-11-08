document.addEventListener('DOMContentLoaded', e => {
  const workspace_url = 'http://localhost:3000/account/workspaces.json';
  const projects_url = 'http://localhost:3000/account/projects.json';

  let search = document.getElementById('search');
  let searchResults = document.getElementById('search-results');

  let workspaces = document.getElementById('workspaces');
  let projects = document.getElementById('projects');

  let workspacesBlock = document.getElementById('workspaces-block');
  let projectsBlock = document.getElementById('projects-block');

  let timer;

  search.addEventListener('keyup', e => {

    clearTimeout(timer)
    timer = setTimeout(() => {
      if (e.target.value) {
        getData(workspace_url,
          workspaces,
          'workspaces',
          'WORKSPACES',
          e.target.value,
          workspacesBlock
        );

        getData(projects_url,
          projects,
          'projects',
          'PROJECTS',
          e.target.value,
          projectsBlock
        );

        searchResults.style.display = 'block';
      } else {
        workspaces.innerHTML = '';
        projects.innerHTML ='';

        searchResults.style.display = 'none';
        workspacesBlock.style.display = 'none';
        projectsBlock.style.display = 'none';
      }
    }, 300);
  })

});

function getData(url, innerObject, objectName, title, search, displayObject) {
  if (search) {
    fetch(`${url}?search=${search}`)
    .then(responce => { return responce.json() })
    .then(responce => {
      if (responce[objectName].length > 0) {
        displayObject.style.display = 'block';
        innerObject.innerHTML = jsonToHTML(responce[objectName], title);
      } else {
        innerObject.innerHTML = '';
        displayObject.style.display = 'none';
      }
    })
    .catch(error => { console.log(error) });
  }
}

function jsonToHTML(data, title) {
  html = `
    <div class='level'>
      <div class='level-left'>
        <div class='level-item'>
          <div class='title is-4'>
            ${title}
          </div>
        </div>
      </div>
    </div>`;

  data.map( element => {
    html += `
      <div class="level is-small">
        <div class="level-left">
          <div class="level-item">
            ${element.name}
          </div>
        </div>
      </div>`
  });

  return html;
}
