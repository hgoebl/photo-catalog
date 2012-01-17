var fs = require('fs'),
    argv = require('optimist')
        .usage('Usage: $0 [options] <input-csv> <output-xml>')
        .demand(2)
        .options('encoding', {
            'default': 'utf8',
            describe: 'character encoding of csv file'
        })
        .argv,
    csv,
    xml;


function renderElement(elementName, data, attr) {
    var attrName,
        attrStr = '',
        __hasOwn = Object.prototype.hasOwnProperty;

    data = data.replace(/&/, '@@@')
        .replace(/</, '&lt;')
        .replace(/>/, '&gt;')
        .replace(/@@@/, '&amp;');

    if (attr) {
        for (attrName in attr) {
            if (__hasOwn.call(attr, attrName)) {
                attrStr += ' ' + attrName + '="' + attr[attrName] + '"';
            }
        }
    }

    return '<' + elementName + attrStr + '>' + data + '</' + elementName + '>';
}

/**
 * Converts a CSV String to an array of arrays (first dimension: lines, second dimension: fields).
 * @param {String} csv
 */
function parseCsv(csv) {
    var out, lines;

    csv = csv.replace('\r\n', '\n');
    csv = csv.replace('\n\r', '\n');
    csv = csv.replace('\r', '\n');
    lines = csv.split('\n');

    out = lines.map(function (line) {
        return line.split(';').map(function (item) {
            return item.trim();
        });
    });

    return out;
}

/**
 * Converts a String (usually coming from a CSV-file) to a catalog xml String.
 * @param {String} csv csv with linefeeds and lines fields separated with ';'
 */
function csvToCatalogXml(csv) {
    var rows,
        fieldNames,
        orientationIdx,
        srcIdx,
        xml = [];

    rows = parseCsv(csv);
    fieldNames = rows[0];
    orientationIdx = fieldNames.indexOf('orientation');
    srcIdx = fieldNames.indexOf('src');

    xml.push('<photos>');
    rows.forEach(function (row, rowIdx) {
        if (rowIdx === 0) return;
        xml.push('<photo>');
        row.forEach(function (field, fieldIdx, row) {
            var attr;
            if (fieldIdx === orientationIdx) {
                return; // skip, will be processed with src field
            }
            if (fieldIdx === srcIdx) {
                attr = {
                    orientation: orientationIdx < 0
                        ? 'landscape'
                        : (row[orientationIdx] || 'landscape')
                };
            }
            xml.push('    ' + renderElement(fieldNames[fieldIdx], field, attr));
        });
        xml.push('</photo>');
    });
    xml.push('</photos>');

    return xml.join('\n');
}

// "main"
csv = fs.readFileSync(argv._[0], argv.encoding);
xml = csvToCatalogXml(csv);
fs.writeFileSync(argv._[1], xml, 'utf8');
