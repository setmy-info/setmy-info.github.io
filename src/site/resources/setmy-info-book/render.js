const pug = require('pug');
const fs = require('fs');
const path = require('path');

/*
npm init -y
npm install pug
*/

const outputDir = 'output';

const pages = [
    {name: "chapter1", title: "Chapter 1"},
    {name: "chapter2", title: "Chapter 2"},
    {name: "chapter4", title: "Chapter 4"},
];

function makeOutputDir(name) {
    if (!fs.existsSync(name)) {
        fs.mkdirSync(name);
    }
}

function makePages() {
    pages.forEach(page => {
        const input = getInputName(page.name);
        const output = getOutputName(page.name);
        const html = pug.renderFile(input, {title: page.title/*, doctype: 'xml',  selfClosing: true */});
        fs.writeFileSync(output, html);
        console.log(`Created: ${output}`);
    });
}

function getInputName(name) {
    return path.join('pug', `${name}.pug`);
}

function getOutputName(name) {
    return path.join(outputDir, `${name}.html`);
}

makeOutputDir(outputDir);
makePages();
