//  
//  This file is part of the OpenLink Software Virtuoso Open-Source (VOS)
//  project.
//  
//  Copyright (C) 1998-2022 OpenLink Software
//  
//  This project is free software; you can redistribute it and/or modify it
//  under the terms of the GNU General Public License as published by the
//  Free Software Foundation; only version 2 of the License, dated June 1991.
//  
//  This program is distributed in the hope that it will be useful, but
//  WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
//  General Public License for more details.
//  
//  You should have received a copy of the GNU General Public License along
//  with this program; if not, write to the Free Software Foundation, Inc.,
//  51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
//  
//  
//
// $Id$
//

using System;

#if ODBC_CLIENT
namespace OpenLink.Data.VirtuosoOdbcClient
#elif CLIENT
namespace OpenLink.Data.VirtuosoClient
#else
namespace OpenLink.Data.Virtuoso
#endif
{
	interface IInnerConnection : IDisposable
	{
		DateTime TimeStamp
		{
			get;
			set;
		}

		WeakReference OuterConnectionWeakRef
		{
			get;
			set;
		}

		VirtuosoConnection OuterConnection
		{
			get;
		}

		bool IsValid ();

		void Open (ConnectionOptions options);

		void Close ();

		void Pool ();

		IInnerCommand CreateInnerCommand (VirtuosoCommand outerCommand);

		void RemoveCommand (VirtuosoCommand outerCommand);

		void BeginTransaction (CLI.IsolationLevel level);

		void EndTransaction (bool commit);

		void Enlist (object distributedTransaction);

		object DistributedTransaction
		{
			get;
			set;
		}

		object DistributedTransactionId
		{
			get;
			set;
		}

		string GetCurrentCatalog ();

		void SetCurrentCatalog (string name);

        string ServerVersion
        {
            get;
        }

#if ADONET2
        String ServerName { get; }
        CLI.IdentCase IdentCase { get; }
        CLI.IdentCase QuotedIdentCase { get; }
		string UserName { get; }
#endif
    }
}
