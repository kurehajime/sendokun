function makeURL(e) {
    const yyyymmdd = document.querySelector('#yyyymmdd').value.replace(/-/g, "")
    const user = document.querySelector('#user').value
    const repo = document.querySelector('#repo').value
    const path = encodeURIComponent(document.querySelector('#path').value)
    let url = location.protocol + "//" + location.host
        + `?yyyymmdd=${yyyymmdd}`
        + `&user=${user}`
        + `&repo=${repo}`
    if (path) {
        url += `&path=${path}`
    }
    document.querySelector('#result').value = url
    document.querySelector('#result_tag').value = `![sendokun](${url})`
}

document.addEventListener('DOMContentLoaded', () => {
    document.querySelector('#make').addEventListener('click', makeURL)
});