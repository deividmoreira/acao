package Acao::Controller::Auth::Admin::Schema;

# Copyright 2010 - Prefeitura Municipal de Fortaleza
#
# Este arquivo é parte do programa Ação - Sistema de Acompanhamento de
# Projetos Sociais
#
# O Ação é um software livre; você pode redistribui-lo e/ou modifica-lo
# dentro dos termos da Licença Pública Geral GNU como publicada pela
# Fundação do Software Livre (FSF); na versão 2 da Licença.
#
# Este programa é distribuido na esperança que possa ser util, mas SEM
# NENHUMA GARANTIA; sem uma garantia implicita de ADEQUAÇÂO a qualquer
# MERCADO ou APLICAÇÃO EM PARTICULAR. Veja a Licença Pública Geral GNU
# para maiores detalhes.
#
# Você deve ter recebido uma cópia da Licença Pública Geral GNU, sob o
# título "LICENCA.txt", junto com este programa, se não, escreva para a
# Fundação do Software Livre(FSF) Inc., 51 Franklin St, Fifth Floor,

use Moose;
use namespace::autoclean;
BEGIN { extends 'Catalyst::Controller'; }
use Data::Dumper;
use utf8;
#use Catalyst::Request::Upload;
#use File::Copy;
use utf8;
with 'Acao::Role::Auditoria' => { category => 'Admin-Schemas' };

my $diretorio = Acao->config->{'Model::Schema'}->{upload_schemas};

sub base : Chained('/auth/admin/base') : PathPart('schema') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub lista : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

}

sub buscar : Chained('base') : PathPart('buscar') : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'auth/admin/schema/lista.tt';
    $c->stash->{busca}    = $c->req->param('busca');
    return;
}

sub form : Chained('base') : PathPart('inserir') : Args(0) {
    my ( $self, $c ) = @_;
    return;
}

sub store : Chained('base') : PathPart('store_upload') : Args(0) {
    my ( $self, $c ) = @_;

    if ( $c->request->parameters->{form_submit} eq 'yes' ) {
        $c->stash->{template} = 'auth/admin/schema/form.tt';
        if ( my $upload = $c->req->upload('uploadSchema') ) {

            my $filename = $upload->filename;
            my $target = $diretorio.$filename;

            if (!($upload->type eq 'application/xml')) {

                $c->flash->{erro} = 'upload-arquivo';
                return;
            }

            unless ( $upload->link_to($target) || $upload->copy_to($target) ) {
                die("Failed to copy '$filename' to '$target': $!");
            }
            my $res = $c->model('Schema')->insere_schema('acao-schemas',$target,$filename);
            if (!$res) {
                $c->flash->{erro} = 'xsd_duplicado';

            } else {
                $c->res->redirect( $c->uri_for_action('/auth/admin/schema/lista') );
                $c->flash->{sucesso} = 'Schema XSD enviado com com sucesso';
            }
        }

    }






    return;
}

sub validacao : Chained('base') : PathPart('validar')  : Args(1) {
    my ( $self, $c, $validacao ) = @_;
    my $XSDtargetNamespace = $c->req->param('XSDtargetNamespace');
    $c->model('Schema')->altera_validacao_schemas( $XSDtargetNamespace, $validacao );
    $c->stash->{template} = 'auth/admin/schema/lista.tt';
    return;
}
1;

