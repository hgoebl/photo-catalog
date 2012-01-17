# photo-catalog

Generates a simple catalog of pictures in PDF format (one picture per page).

This piece of software is used privately for my parents atelier <http://www.simssee-atelier.de/>.
You can use or tweak it as you like - it's not meant to be usable universally ;-)

## Source

An XML file with data about the pictures

    <photos>
        <info>
            <header-right>Malerei</header-right>
            <header-left>www.simssee-atelier.de</header-left>
            <author>Brigitte Göbl</author>
            <date>16.01.2012</date>
        </info>
        <photo>
            <src orientation="portrait">small-IMG01.jpg</src>
            <title>Seelenlandschaft</title>
            <subtitle1>80 x 120 cm (m.R.)</subtitle1>
            <subtitle2>Acryl</subtitle2>
            <info>900</info>
        </photo>
        <photo>
            <src orientation="portrait">small-IMG02.jpg</src>
            <title>Zwischenspiel</title>
            <subtitle1>80 x 120 cm (m.R.)</subtitle1>
            <subtitle2>Acryl</subtitle2>
            <info>900</info>
        </photo>
    </photos>

## Destination

A PDF file like this sample: <http://www.simssee-atelier.de/download/git-sample.pdf>

## Pre-Processing

For those not willing to edit too much XML, a CSV file can be used as well (Node.js needed):

    node node-app/csv-to-catalog-xml.js --encoding=utf8 sample/paintings.txt sample/catalog.xml

**Be careful not to overwrite your edited xml-file!**

## Generating PDF

You need Apache FOP and Java Runtime Environment (for a description see my GitHub project [it-profile-generator](https://github.com/hgoebl/it-profile-generator).

    ./generate.sh <catalog-folder:=sample> <catalog-name:=catalog>

## License

Public domain.
