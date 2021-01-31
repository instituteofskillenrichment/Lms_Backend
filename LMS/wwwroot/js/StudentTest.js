function generateQuestions(type, text, count, obj, questionId) {
    var content = `<div class="questionObj" id=` + questionId + `><div class="row"><div class="col-md-12 pr-1"><div class="form-group"><label>Question ` + (parseInt(count, 10) + 1) + `</label><div class="form-control"><p disabled="true">` + text + `</p></div></div></div></div>`;
    if (type == 1) {
        content += generateMultipleTextControl(obj, count);
    } else if (type == 2) {
        content += generateTextControl(count, type);
    } else {
        content += generateFileControl(count, type);
    }
    console.log(content);
    return content + `<br/>`;
}